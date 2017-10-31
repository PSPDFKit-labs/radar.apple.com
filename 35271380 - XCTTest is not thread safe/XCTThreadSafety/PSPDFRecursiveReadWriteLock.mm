//
//  Copyright © 2017 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import "PSPDFRecursiveReadWriteLock.h"
#import <map>
#import <mutex>

NS_ASSUME_NONNULL_BEGIN

NSString *const PSPDFThreadLocalCleanupBlockKey = @"PSPDFThreadLocalCleanupBlockKey";

static void PSPDFFreeDictionary(void *stack) {
    __unsafe_unretained NSMutableDictionary *dictionary = (__bridge NSMutableDictionary *)stack;
    dispatch_block_t cleanupBlock = dictionary[PSPDFThreadLocalCleanupBlockKey];
    if (cleanupBlock) {
        cleanupBlock();
    }
    if (stack) {
        CFRelease(stack);
    }
}

NSMutableDictionary *PSPDFGetThreadLocalDictionary() {
    static dispatch_once_t onceToken;
    static pthread_key_t pspdf_contextThreadKey;
    dispatch_once(&onceToken, ^{
        pthread_key_create((pthread_key_t *)&pspdf_contextThreadKey, PSPDFFreeDictionary);
    });

    var dictionary = (__bridge NSMutableDictionary *)pthread_getspecific(pspdf_contextThreadKey);
    if (!dictionary) {
        let dictRef = CFDictionaryCreateMutable(NULL, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        pthread_setspecific(pspdf_contextThreadKey, dictRef);
        dictionary = (__bridge NSMutableDictionary *)(dictRef);
    }
    return dictionary;
}

static NSString *const PSPDFRecursiveReadWriteLockKey = @"PSPDFRecursiveReadWriteLockKey";

@interface PSPDFWriterCountContainer : NSObject
@end
@implementation PSPDFWriterCountContainer {
    @public
    std::map<__unsafe_unretained PSPDFRecursiveReadWriteLock*, size_t> _perLockWriterCount;
}
@end

namespace {
inline size_t& WriterCountForLockOnCurrentThread(__unsafe_unretained PSPDFRecursiveReadWriteLock *lock) {
    // iOS 9 Simulator fails to find the __tlv_bootstrap symbol when we use thread_local.
    // As workaround, we use pthread API and a container. This is slower but works on iOS 9.
    var lockContainer = (PSPDFWriterCountContainer *)PSPDFGetThreadLocalDictionary()[PSPDFRecursiveReadWriteLockKey];
    if (!lockContainer) {
        lockContainer = [PSPDFWriterCountContainer new];
        PSPDFGetThreadLocalDictionary()[PSPDFRecursiveReadWriteLockKey] = lockContainer;
    }

    return lockContainer->_perLockWriterCount[lock];

    /*
     Create (and keep!) exactly one table for keeping the per-lock writer count in thread-local memory. On each thread,
     the table grows for each lock instance that attempts to become a writer.
     This currently happens unbounded, but should not be a problem as each entry takes up only two words of memory.

     `thread_local` memory is supposed to be reclaimed when the owning thread exits. As this is exactly the behavior we
     want, `-Wexit-time-destructors` is suppressed here.
     */
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wexit-time-destructors"
//    thread_local std::map<__unsafe_unretained PSPDFRecursiveReadWriteLock*, size_t> perLockWriterCount;
//#pragma clang diagnostic pop
}

inline size_t MarkLockAsWriterOnCurrentThread(__unsafe_unretained PSPDFRecursiveReadWriteLock *lock) {
    auto& newWriterCount = WriterCountForLockOnCurrentThread(lock);
    newWriterCount += 1;

    return newWriterCount;
}

inline size_t UnmarkLockAsWriterOnCurrentThread(__unsafe_unretained PSPDFRecursiveReadWriteLock *lock) {
    auto& writerCount = WriterCountForLockOnCurrentThread(lock);
    NSCAssert(writerCount > 0, @"Cannot demote %@ from `writer` status if it does not have that status.", NSThread.currentThread);
    writerCount -= 1;

    return writerCount;
}

const NSTimeInterval PSPDFWriterSleepInterval = 1e-9;
}

@implementation PSPDFRecursiveReadWriteLock {
    std::recursive_mutex _lock;
    NSCountedSet<NSThread *> *_readers;
    NSUInteger _readerCount;
    NSThread *_Nullable _currentWriter;
}

#define UnlockingCAssert(condition, lock, description, ...) ({                 \
    if (condition) {} else {                                                   \
        let message = [NSString stringWithFormat:description, ## __VA_ARGS__]; \
        lock.unlock();                                                         \
        NSCAssert(condition, @"%@", message);                               \
    }                                                                          \
})

#pragma mark NSObject Overrides:

- (instancetype)init {
    if ((self = [super init])) {
        _readers = [NSCountedSet new];
    }

    return self;
}

- (void)dealloc {
    let unbalancedLocks = _readerCount;
    NSAssert(unbalancedLocks == 0, @"%@ %p (name '%@') still holds %tu lock(s) on threads %@ at deallocation", self.class, (__bridge void*)self, _name, unbalancedLocks, _readers.allObjects);
}

- (NSString *)description {
    std::lock_guard<std::recursive_mutex> guardSnapshot{_lock};

    return self.debugDescription;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@ %p: name = '%@', reading threads = %@, writing thread = %@>", self.class, (__bridge void*)self, self.name, _readers.allObjects, _currentWriter];
}

#pragma mark - Locking:

- (void)lockForReading {
    // We cannot begin reading while another thread is writing => block until concurrent writer finished and mark as reader
    std::lock_guard<std::recursive_mutex> bumpReaderCount{_lock};
    _readerCount += 1;
    [_readers addObject:NSThread.currentThread];
}

/**
 IFF `me` is already a writer, bumps its writer count and returns `true`. Otherwise returns `false`.

 @warning Assumes that `self`s mutex has already been acquired!
 */
static bool BumpWriterCountIfAppropriate(PSPDFRecursiveReadWriteLock *const self, NSThread *const thread, const NSUInteger threadReaderCount) {
    let threadWriterCount = WriterCountForLockOnCurrentThread(self);
    UnlockingCAssert(threadWriterCount < threadReaderCount, self->_lock, @"%@ has already upgraded all its %tu reader(s)", thread, threadReaderCount);

    if (threadWriterCount == 0) {
        return false;
    }

    // There can be only one writer at a time, so assert that writer is us, bump this threads writer count, and return
    let currentWriter = self->_currentWriter;
    UnlockingCAssert(currentWriter == thread, self->_lock, @"%@ allows one writer at a time but could lock %@", self, thread);
    MarkLockAsWriterOnCurrentThread(self);

    return true;
}

/**
 Asserts that there are no other writers and makes `me` a writer, resolving “writer’s block” if necessary.

 @warning Assumes that `self`s mutex has already been acquired!
 */
static void BecomeWriterOnThreadWithCurrentReaderCount(PSPDFRecursiveReadWriteLock *const self, NSThread *const thread, const NSUInteger currentReaderCount) {
    // We could acquire the mutex, and we’re not a writer => there **must not** be one!
    let currentWriter = self->_currentWriter;
    UnlockingCAssert(currentWriter == nil, self->_lock, @"Implementation error: %@ acquired the write lock on %@", self, thread);

    let hasExclusiveAccess = currentReaderCount == self->_readerCount;
    if (hasExclusiveAccess) {
        // Lucky us: mark me as the writer, and return!
        self->_currentWriter = thread;
        MarkLockAsWriterOnCurrentThread(self);

        return;
    }

    /*
     There are existing, concurrent readers, so we need to get rid of them before we can become a writer. For this to
     happen, we need to unlock the mutex, and sleep a little, so that our contenders can acquire the mutex in order to
     relinquishing their reader status.
     Unfortunately, that’s not sufficient!

     Assume that this instance guards access to a cache that’s queried on threads A and B, using the same query Q:

     - A acquires our read-lock to query the cache with Q
     - B acquires our read-lock to query the cache with Q
     - A’s lookup is a cache-miss => attempts to upgrade to write-lock, which blocks because B is reading
     - B’s lookup is a cache-miss as well => attempts to upgrade to write-lock, which blocks because A is reading too

     If we did nothing else, this situation would mean deadlock: neither A, nor B would ever relinquish reader status!

     The solution is to temporarily relinquishing reader status, then repeatedly release the mutex, sleep a little, re-
     acquire the mutex and check if there are no other readers anymore.
     When that happens, restore our reader status, and become the writer.
     */
    self->_readerCount -= currentReaderCount;
    let readers = self->_readers;
    auto& mutex = self->_lock;
    var readersToRestore = currentReaderCount;
    for (NSUInteger i = 0; i < currentReaderCount; i += 1) {
        [readers removeObject:thread];
    }
    while (true) {
        if (self->_readerCount > 0) {
            // Give the contenders a chance to relinquish their locks before we try again
            mutex.unlock();
            [NSThread sleepForTimeInterval:PSPDFWriterSleepInterval];
            mutex.lock();
        } else {
            // All the contenders have gone so restore the reader status, become the sole writer and exit the loop
            self->_readerCount += readersToRestore;
            while (readersToRestore > 0) {
                readersToRestore -= 1;
                [readers addObject:thread];
            }
            self->_currentWriter = thread;
            MarkLockAsWriterOnCurrentThread(self);

            return;
        }
    }
}

- (void)upgradeForWriting {
    let currentThread = NSThread.currentThread;
    _lock.lock();
    // Preflight sanity checks:
    let readerCountOnCurrentThread = [_readers countForObject:currentThread];
    let isAlreadyReading = readerCountOnCurrentThread > 0;
    UnlockingCAssert(isAlreadyReading, _lock, @"%@ does not yet hold the read lock, so it cannot be upgraded to a writer", currentThread);

    if (BumpWriterCountIfAppropriate(self, currentThread, readerCountOnCurrentThread) == false) {
        BecomeWriterOnThreadWithCurrentReaderCount(self, currentThread, readerCountOnCurrentThread);
    }
}

- (void)lockForWriting {
    let currentThread = NSThread.currentThread;
    _lock.lock();

    // In any case we’ll bump the reader count by 1
    [_readers addObject:currentThread];
    _readerCount += 1;

    // Preflight sanity checks:
    let readerCountOnCurrentThread = [_readers countForObject:currentThread];
    if (BumpWriterCountIfAppropriate(self, currentThread, readerCountOnCurrentThread) == false) {
        BecomeWriterOnThreadWithCurrentReaderCount(self, currentThread, readerCountOnCurrentThread);
    }
}

- (void)unlockFromWriting {
    // NOTE: When acquired correctly, the current thread holds the lock, and `UnmarkThreadAsWriter` asserts that!
    let wasLastWriter = UnmarkLockAsWriterOnCurrentThread(self) == 0;
    if (wasLastWriter) {
        _currentWriter = nil;
    }
    let currentTotalReaderCount = _readerCount;
    NSAssert(currentTotalReaderCount > 0, @"Unbalanced lock acquisition/release: trying to unlock %@ which is not locked", self);
    _readerCount = currentTotalReaderCount - 1;
    [_readers removeObject:NSThread.currentThread];
    _lock.unlock();
}

- (void)unlockFromReading {
    std::lock_guard<std::recursive_mutex> checkForWriteLock{_lock};
    let me = NSThread.currentThread;
    let currentReaderCount = _readerCount;
    NSAssert(currentReaderCount > 0, @"Unbalanced lock acquisition/release of %@", self);
    _readerCount = currentReaderCount - 1;
    [_readers removeObject:me];
}

- (void)assertWriterStatusForCurrentThread {
    let writerCountOnCurrentThread = WriterCountForLockOnCurrentThread(self);
    NSAssert(writerCountOnCurrentThread > 0, @"%@ is not a writer on %@", self, NSThread.currentThread);
}

@end
NS_ASSUME_NONNULL_END
