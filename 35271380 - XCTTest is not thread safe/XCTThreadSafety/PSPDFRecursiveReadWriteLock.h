//
//  Copyright © 2017 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import <Foundation/Foundation.h>

// Swift-like shortcut for auto const
// https://pspdfkit.com/blog/2017/even-swiftier-objective-c/

#if defined(__cplusplus)
#define let auto const
#define var auto
#else
#define let const __auto_type
#define var __auto_type
#endif

NS_ASSUME_NONNULL_BEGIN
/**
 A recursive lock, that allows multiple concurrent readers, and a single writing thread at a time.

 This class implements an unfair lock with the following characteristics:

 - there can be multiple concurrent readers
 - the reader lock can be acquired recursively
 - a reader can be upgraded to a writer — given that all concurrent readers have relinquished their read-lock
 - the thread owning writer status can recursively acquire more read or write locks
 - a thread with writer status blocks any concurrent readers

 This locking scheme is required for Instant’s annotation provider, but Foundation does not provide such a thing, and
 `std::condition_variable::wait` does not support `std::recursive_mutex`.

 @note **Important:** `lock…`/`unlock…` calls need to be matched **on the same thread**! A lock that has been acquired
 on one thread **has to be** released on the same thread. Specifically, things like the following are unsupported:
 ```
 let rwLock = PSPDFRecursiveReadWriteLock()
 DispatchQueue.default.async {
     rwLock.lockForReading()
 }
 DispatchQueue.default.barrierAsync {
     rwLock.unlockFromReading() // <- undefined behavior: may or may not be executed on the same thread!
 }
 ```
 (Apart from being unsupported, the above is semantically nonsense.)
 */
@interface PSPDFRecursiveReadWriteLock : NSObject

/// Customizable name of the receiver.
@property (atomic, copy, nullable) NSString *name;

/**
 Blocks until the current thread could acquire the read lock.

 When the current thread already owns the write lock, this method will return immediately. Otherwise, it will repeatedly
 try to acquire the read lock until it succeeds.
 @note Calls to this method need to be balanced by a call to `unlockFromReading` **on the same thread**. You can also
 “upgrade” the thread from a reader to a writer, by calling `upgradeForWriting` if necessary.
 */
- (void)lockForReading;

/**
 Blocks until the currently reading thread could be upgraded to a writer.

 @note Calls to this method need to be preceded by a call to `lockForReading` **on the same thread**. Semantically, this
 combination is equivalent to just calling `lockForWriting`.
 @warning It is a programmer error to call this method on a thread that does not already own the read lock. As such,
 doing so will crash the program.
 Similarly, it is a programmer error to call this method on a thread that has already been “fully upgraded” as a writer.
 (That is, for every call to `lockForReading` there has already been a call to `upgradeForWriting`.)
 */
- (void)upgradeForWriting;

/**
 Blocks until the current thread could acquire the write lock.

 @note Calls to this method need to be balanced by a call to `unlockFromWriting` **on the same thread**.
 */
- (void)lockForWriting;

/**
 Balances a call to `lockForWriting`, or the sequence `lockForReading`, `upgradeForWriting` on the current thread.

 @warning It is a programmer error to call this method on a thread that does not already own the write lock. As such,
 doing so will crash the program.
 */
- (void)unlockFromWriting;

/**
 Balances a call to `lockForReading` on the current thread.

 @warning It is a programmer error to call this method on a thread that does not already own the read lock. As such,
 doing so will crash the program.
 */
- (void)unlockFromReading;

/**
 Asserts that the current thread has writer status.

 Non-locking method to verify correctness in situations where the caller is responsible to hold the write lock for a
 resource (for example the implementation of `-[PSPDFInstantAnnotationProvider needsLocking_flushPendingChanges]`).
 */
- (void)assertWriterStatusForCurrentThread;

@end
NS_ASSUME_NONNULL_END
