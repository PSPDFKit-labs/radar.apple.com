//
//  Copyright © 2017 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import <XCTest/XCTest.h>
#import "PSPDFRecursiveReadWriteLock.h"

/**
 Note: all these tests spin up additional threads to avoid deadlocking in case the subject is implemented incorrectly!
 */
@interface PSPDFRecursiveReadWriteLockTests : XCTestCase @end

#pragma mark -

@protocol ExpectationBuilder <NSObject>

- (XCTestExpectation *)threadStarted;
- (XCTestExpectation *)becameReader;
- (XCTestExpectation *)finishedReading;
- (XCTestExpectation *)becameWriter;
- (XCTestExpectation *)finishedWriting;

@end

#define WAIT_FOR(expectation, ...) [self waitForExpectations:@[expectation, ## __VA_ARGS__] timeout:3]

@interface PSPDFRecursiveReadWriteLockTests (Builder)

- (id<ExpectationBuilder>)newBuilderWithThreadDescription:(NSString *)description, ... NS_FORMAT_FUNCTION(1, 2);

@end

@implementation PSPDFRecursiveReadWriteLockTests

- (void)sleepSome {
    [NSThread sleepForTimeInterval:1e-3 * (arc4random_uniform(100) + 1)];
}

- (void)internal_runBlock:(dispatch_block_t)block {
    @autoreleasepool {
        block();
    }
}

/// Shim to make tests runnable on iOS 9 (which doesn’t have +[NSThread detachNewThreadWithBlock:])
- (void)detachNewThreadWithBlock:(dispatch_block_t)work {
    [NSThread detachNewThreadSelector:@selector(internal_runBlock:) toTarget:self withObject:work];
}


- (void)testAssertWriterStatus {
    let subject = [PSPDFRecursiveReadWriteLock new];
    XCTAssertThrows([subject assertWriterStatusForCurrentThread], @"Pristine lock must not claim to be writer");

    let didFinish = [self expectationWithDescription:@"Thread finished"];
    [self detachNewThreadWithBlock:^{
        [subject lockForWriting];
        XCTAssertNoThrow([subject assertWriterStatusForCurrentThread], @"Actual writer must not assert");
        [subject unlockFromWriting];
        [didFinish fulfill];
    }];
    WAIT_FOR(didFinish);
}

- (void)testAllowsConcurrentReaders {
    let subject = [PSPDFRecursiveReadWriteLock new];

    var builder = [self newBuilderWithThreadDescription:@"Thread 1"];
    let firstBecameReader = [builder becameReader];
    let firstThreadFinished = [builder finishedReading];

    builder = [self newBuilderWithThreadDescription:@"Thread 2"];
    let secondThreadStarted  = [builder threadStarted];
    let secondBecameReader = [builder becameReader];
    let secondThreadFinished = [builder finishedReading];
    [self detachNewThreadWithBlock:^{
        WAIT_FOR(secondThreadStarted);
        [subject lockForReading];
        [firstBecameReader fulfill];

        WAIT_FOR(secondBecameReader);
        [self sleepSome];
        [subject unlockFromReading];
        [firstThreadFinished fulfill];
    }];
    [self detachNewThreadWithBlock:^{
        [secondThreadStarted fulfill];

        WAIT_FOR(firstBecameReader);
        [subject lockForReading];
        [secondBecameReader fulfill];

        [self sleepSome];
        [subject unlockFromReading];
        [secondThreadFinished fulfill];
    }];
    WAIT_FOR(firstThreadFinished, secondThreadFinished);
}

- (void)testDeniesConcurrentReaderWhenWriting {
    let subject = [PSPDFRecursiveReadWriteLock new];

    // Make atomic to keep TSan happy.
    _Atomic __block BOOL writerOwnsExclusiveLock = NO;

    var builder = [self newBuilderWithThreadDescription:@"Designated writer"];
    let writerLocked = [builder becameWriter];
    let writerFinished = [builder finishedWriting];

    builder = [self newBuilderWithThreadDescription:@"Concurrent reader"];
    let readerStarted = [builder threadStarted];
    let readerFinished = [builder finishedReading];

    [self detachNewThreadWithBlock:^{
        WAIT_FOR(readerStarted);
        [subject lockForWriting];
        writerOwnsExclusiveLock = YES;
        [writerLocked fulfill];

        // Wait for a little, so that the reader thread can wake up and hammer the lock before downgrading the accessor.
        [self sleepSome];
        writerOwnsExclusiveLock = NO;
        [subject unlockFromWriting];
        [writerFinished fulfill];
    }];

    [self detachNewThreadWithBlock:^{
        [readerStarted fulfill];
        WAIT_FOR(writerLocked);
        NSAssert(writerOwnsExclusiveLock, @"Test borked: reader thread should have woken up after the writer acquired the lock");

        [subject lockForReading];
        XCTAssertFalse(writerOwnsExclusiveLock, @"Should not be able to acquire reader lock while there is a writer");
        [subject unlockFromReading];
        [readerFinished fulfill];
    }];
    WAIT_FOR(writerFinished, readerFinished);
}

- (void)testGrantsWriteLockToExclusiveReader {
    let subject = [PSPDFRecursiveReadWriteLock new];
    let builder = [self newBuilderWithThreadDescription:@"Upgradable reader"];
    let read = [builder becameReader];
    let upgrade = [builder becameWriter];
    let unlock = [builder finishedWriting];
    [self detachNewThreadWithBlock:^{
        [subject lockForReading];
        [read fulfill];

        [subject upgradeForWriting];
        [upgrade fulfill];

        [subject unlockFromWriting];
        [unlock fulfill];
    }];
    [self waitForExpectations:@[read, upgrade, unlock] timeout:1 enforceOrder:YES];
}

- (void)testAllowsRecursiveReadLocking {
    let subject = [PSPDFRecursiveReadWriteLock new];
    let initialRead = [self expectationWithDescription:@"Acquired initial read lock"];
    let recursiveRead = [self expectationWithDescription:@"Acquired recursive read lock"];
    let unlockRecursedRead = [self expectationWithDescription:@"Relinquished recursive read lock"];
    let unlockInitialRead = [self expectationWithDescription:@"Relinquished initial read lock"];
    [self detachNewThreadWithBlock:^{
        [subject lockForReading];
        [initialRead fulfill];

        [subject lockForReading];
        [recursiveRead fulfill];

        [subject unlockFromReading];
        [unlockRecursedRead fulfill];

        [subject unlockFromReading];
        [unlockInitialRead fulfill];
    }];
    WAIT_FOR(initialRead, recursiveRead, unlockRecursedRead, unlockInitialRead);
}

- (void)testAllowsRecursiveWriteLocking {
    let subject = [PSPDFRecursiveReadWriteLock new];
    let initialRead = [self expectationWithDescription:@"Acquired initial read lock"];
    let recursiveWrite = [self expectationWithDescription:@"Acquired write lock"];
    let unlockRecursedWrite = [self expectationWithDescription:@"Relinquished write lock"];
    let unlockInitialRead = [self expectationWithDescription:@"Relinquished initial read lock"];
    [self detachNewThreadWithBlock:^{
        [subject lockForReading];
        [initialRead fulfill];

        [subject lockForWriting];
        [recursiveWrite fulfill];

        [subject unlockFromWriting];
        [unlockRecursedWrite fulfill];

        [subject unlockFromReading];
        [unlockInitialRead fulfill];
    }];
    WAIT_FOR(initialRead, recursiveWrite, unlockRecursedWrite, unlockInitialRead);
}

- (void)testDeniesWriteLockWhileThereAreOtherReaders {
    let subject = [PSPDFRecursiveReadWriteLock new];
    var builder = [self newBuilderWithThreadDescription:@"Reader"];
    let readerLocked = [builder becameReader];
    let readerUnlocked = [builder finishedReading];

    builder = [self newBuilderWithThreadDescription:@"Writer"];
    let writerStarted = [builder threadStarted];
    __block BOOL hasActiveReader = NO;
    let writerCheckedCounter = [self expectationWithDescription:@"Writer did check counter"];
    let writerFinished = [builder finishedWriting];
    [self detachNewThreadWithBlock:^{
        [writerStarted fulfill];

        WAIT_FOR(readerLocked);
        XCTAssertTrue(hasActiveReader);
        [writerCheckedCounter fulfill];

        [subject lockForWriting];
        XCTAssertFalse(hasActiveReader);
        [subject unlockFromWriting];
        [writerFinished fulfill];
    }];

    [self detachNewThreadWithBlock:^{
        WAIT_FOR(writerStarted);

        [subject lockForReading];
        hasActiveReader = YES;
        [readerLocked fulfill];

        WAIT_FOR(writerCheckedCounter);
        [self sleepSome];
        hasActiveReader = NO;
        [subject unlockFromReading];
        [readerUnlocked fulfill];
    }];

    WAIT_FOR(readerUnlocked, writerFinished);
}

- (void)testDeniesConcurrentWriters1 { [self testDeniesConcurrentWriters]; }
- (void)testDeniesConcurrentWriters2 { [self testDeniesConcurrentWriters]; }
- (void)testDeniesConcurrentWriters3 { [self testDeniesConcurrentWriters]; }
- (void)testDeniesConcurrentWriters4 { [self testDeniesConcurrentWriters]; }
- (void)testDeniesConcurrentWriters5 { [self testDeniesConcurrentWriters]; }
- (void)testDeniesConcurrentWriters6 { [self testDeniesConcurrentWriters]; }
- (void)testDeniesConcurrentWriters7 { [self testDeniesConcurrentWriters]; }
- (void)testDeniesConcurrentWriters8 { [self testDeniesConcurrentWriters]; }
- (void)testDeniesConcurrentWriters9 { [self testDeniesConcurrentWriters]; }
- (void)testDeniesConcurrentWriters0 { [self testDeniesConcurrentWriters]; }

- (void)testDeniesConcurrentWriters {
    for (int iteration = 1; iteration <= 1000; iteration++) {
        //@autoreleasepool
        {
            let subject = [PSPDFRecursiveReadWriteLock new];
            let initialValue = @"Initial value";
            let firstUpdate = @"Value to be written by writer 1";
            let secondUpdate = @"Value to be written by writer 2";

            __block var guardedValue = initialValue;
            var builder = [self newBuilderWithThreadDescription:@"Writer 1 (iteration %d)", iteration];
            let firstBecameWriter = [builder becameWriter];
            let firstFinished = [builder finishedWriting];

            builder = [self newBuilderWithThreadDescription:@"Writer 2 (iteration %d)", iteration];
            let secondStarted = [builder threadStarted];
            let secondFinished = [builder finishedWriting];

            [self detachNewThreadWithBlock:^{
                [subject lockForWriting];
                [firstBecameWriter fulfill];
                WAIT_FOR(secondStarted);

                XCTAssertEqualObjects(guardedValue, initialValue, @"From our setup, this should be untouched for iteration %d", iteration);
                [self sleepSome];

                guardedValue = firstUpdate;
                [subject unlockFromWriting];
                [firstFinished fulfill];
            }];

            [self detachNewThreadWithBlock:^{
                WAIT_FOR(firstBecameWriter);
                [secondStarted fulfill];

                [subject lockForWriting];
                XCTAssertEqualObjects(guardedValue, firstUpdate, @"This should have been touched by writer 1 (iteration %d)", iteration);
                guardedValue = secondUpdate;

                [subject unlockFromWriting];
                [secondFinished fulfill];
            }];

            WAIT_FOR(firstFinished, secondFinished);
            XCTAssertEqualObjects(guardedValue, secondUpdate, @"After both threads are done, the second update should have been persisted (iteration %d)", iteration);
        }
    }
}

- (void)testAllowsUpgradingExclusiveReaderToWriter {
    let subject = [PSPDFRecursiveReadWriteLock new];
    let builder = [self newBuilderWithThreadDescription:@"Reader that is upgraded"];
    let becameReader = [builder becameReader];
    let becameWriter = [builder becameWriter];
    let unlockedWriter = [builder finishedWriting];
    [self detachNewThreadWithBlock:^{
        [subject lockForReading];
        [becameReader fulfill];

        [subject upgradeForWriting];
        [becameWriter fulfill];

        [subject unlockFromWriting];
        [unlockedWriter fulfill];
    }];
    [self waitForExpectations:@[becameReader, becameWriter, unlockedWriter] timeout:1 enforceOrder:YES];
}

- (void)testDeniesUpgradeToWriterWhileThereAreOtherReaders {
    for (int iteration = 1; iteration <= 100; iteration++) {
        let subject = [PSPDFRecursiveReadWriteLock new];

        var builder = [self newBuilderWithThreadDescription:@"Upgradable reader %d", iteration];
        let didUpgradeToWriter = [builder becameWriter];
        let writerFinished = [builder finishedWriting];

        builder = [self newBuilderWithThreadDescription:@"Reader %d", iteration];
        let readerLocked = [builder becameReader];
        let readerBlockedWriter = [self expectationWithDescription:[NSString stringWithFormat:@"Reader %d slept", iteration]];
        let readerFinished = [builder finishedReading];
        [self detachNewThreadWithBlock:^{
            WAIT_FOR(readerLocked);
            [subject lockForReading];

            [subject upgradeForWriting];
            [didUpgradeToWriter fulfill];

            [subject unlockFromWriting];
            [writerFinished fulfill];
        }];

        [self detachNewThreadWithBlock:^{
            [subject lockForReading];
            [readerLocked fulfill];

            [self sleepSome];
            [readerBlockedWriter fulfill];

            [subject unlockFromReading];
            [readerFinished fulfill];
        }];

        WAIT_FOR(writerFinished, readerFinished);
        [self waitForExpectations:@[readerBlockedWriter, didUpgradeToWriter] timeout:0 enforceOrder:YES];
    }
}

- (void)testRejectsUnbalancedReaderUnlocking {
    let subject = [PSPDFRecursiveReadWriteLock new];
    XCTAssertThrows([subject unlockFromReading]);
}

- (void)testRejectsUnbalancedWriterUnlocking {
    let subject = [PSPDFRecursiveReadWriteLock new];
    XCTAssertThrows([subject unlockFromWriting]);
}

- (void)testRejectsImproperReaderUpgrade {
    let subject = [PSPDFRecursiveReadWriteLock new];
    XCTAssertThrows([subject upgradeForWriting]);
}

- (void)testCanResolveWritersBlock {
    let subject = [PSPDFRecursiveReadWriteLock new];
    var builder = [self newBuilderWithThreadDescription:@"Thread 1"];
    let firstBecameReader = [builder becameReader];
    let firstBecameWriter = [builder becameWriter];
    let firstFinished = [builder finishedWriting];

    builder = [self newBuilderWithThreadDescription:@"Thread 2"];
    let secondBecameReader = [builder becameReader];
    let secondBecameWriter = [builder becameWriter];
    let secondFinished = [builder finishedWriting];

    let nonstandardQOS = NSQualityOfServiceUserInitiated;
    [self detachNewThreadWithBlock:^{
        NSThread.currentThread.qualityOfService = nonstandardQOS;
        [subject lockForReading];
        [firstBecameReader fulfill];

        WAIT_FOR(secondBecameReader);
        [subject upgradeForWriting];
        [firstBecameWriter fulfill];

        [self sleepSome];
        [subject unlockFromWriting];
        [firstFinished fulfill];
    }];

    [self detachNewThreadWithBlock:^{
        NSThread.currentThread.qualityOfService = nonstandardQOS;
        [subject lockForReading];
        [secondBecameReader fulfill];

        WAIT_FOR(firstBecameReader);
        [subject upgradeForWriting];
        [secondBecameWriter fulfill];

        [self sleepSome];
        [subject unlockFromWriting];
        [secondFinished fulfill];
    }];
    WAIT_FOR(firstBecameWriter, firstFinished, secondBecameWriter, secondFinished);
}

/// Reproduces a nasty flaw of the initial implementation
- (void)testCorrectlyTracksLockingOfMultipleInstances {
    let one = [PSPDFRecursiveReadWriteLock new];
    let two = [PSPDFRecursiveReadWriteLock new];

    let threadFinished = [self expectationWithDescription:@"Thread finished running"];
    [self detachNewThreadWithBlock:^{
        [one lockForWriting];
        XCTAssertThrows([two assertWriterStatusForCurrentThread], @"never locked %@ but claimed to be", two);
        [one unlockFromWriting];

        [two lockForWriting];
        XCTAssertThrows([one assertWriterStatusForCurrentThread], @"unlocked %@ but claimed to still be", one);
        [two unlockFromWriting];
        [threadFinished fulfill];
    }];
    WAIT_FOR(threadFinished);
}

/*
 Typical crash on CI: https://gist.github.com/steipete/2ec99bca9dd01e405f9fd7db17472cb5
 Usually in PSPDFRecursiveReadWriteLockTests.testDeniesConcurrentWriters
 Test Case '-[PSPDFRecursiveReadWriteLockTests testDeniesConcurrentWriters]' started.
 2017-10-31 14:35:15.885 XCTThreadSafety[44715:2676712] *** -[XCTWaiter release]: message sent to deallocated instance 0x60200003abb0

 This happens in is dispatch queue: com.apple.dt.async-test-expectation
 (lldb) bt
 * thread #17, queue = 'com.apple.dt.async-test-expectation', stop reason = EXC_BREAKPOINT (code=EXC_I386_BPT, subcode=0x0)
 * frame #0: 0x000000010ece876f CoreFoundation`___forwarding___ + 815
 frame #1: 0x000000010ece83b8 CoreFoundation`__forwarding_prep_0___ + 120
 frame #2: 0x000000010d44d4b2 libclang_rt.asan_iossim_dynamic.dylib`__wrap_dispatch_async_block_invoke + 290
 frame #3: 0x0000000111aac585 libdispatch.dylib`_dispatch_call_block_and_release + 12
 frame #4: 0x0000000111acd792 libdispatch.dylib`_dispatch_client_callout + 8
 frame #5: 0x0000000111ab3237 libdispatch.dylib`_dispatch_queue_serial_drain + 1022
 frame #6: 0x0000000111ab398f libdispatch.dylib`_dispatch_queue_invoke + 1053
 frame #7: 0x0000000111ab3d31 libdispatch.dylib`_dispatch_queue_override_invoke + 374
 frame #8: 0x0000000111ab5899 libdispatch.dylib`_dispatch_root_queue_drain + 813
 frame #9: 0x0000000111ab550d libdispatch.dylib`_dispatch_worker_thread3 + 113
 frame #10: 0x0000000111e641ca libsystem_pthread.dylib`_pthread_wqthread + 1387
 frame #11: 0x0000000111e63c4d libsystem_pthread.dylib`start_wqthread + 13

 xcodebuild test -scheme XCTThreadSafety -destination "platform=iOS Simulator,name=iPad Air,OS=10.3.1"

 Restarting after unexpected exit or crash in PSPDFRecursiveReadWriteLockTests/testDeniesConcurrentWriters; summary will include totals from previous launches.
 */
- (void)testEverythingALot {
    for (NSUInteger i=0; i < 100; i++) {
        [self testDeniesConcurrentWriters];
        /*
         [self testAssertWriterStatus];
         [self testAllowsConcurrentReaders];
         [self testDeniesConcurrentReaderWhenWriting];
         [self testGrantsWriteLockToExclusiveReader];
         [self testAllowsRecursiveReadLocking];
         [self testAllowsRecursiveWriteLocking];
         [self testDeniesWriteLockWhileThereAreOtherReaders];
         [self testDeniesConcurrentWriters];
         [self testAllowsUpgradingExclusiveReaderToWriter];
         [self testDeniesUpgradeToWriterWhileThereAreOtherReaders];
         [self testRejectsUnbalancedReaderUnlocking];
         [self testRejectsUnbalancedWriterUnlocking];
         [self testRejectsImproperReaderUpgrade];
         [self testCanResolveWritersBlock];
         [self testCorrectlyTracksLockingOfMultipleInstances];*/
    }
}

@end

@interface RWLockExpectationBuilder : NSObject <ExpectationBuilder>
@property (nonatomic, readonly) NSString *threadDescription;
@property (nonatomic, readonly) XCTestCase *testCase;
@end

@implementation RWLockExpectationBuilder

- (instancetype)initWithThreadDescription:(NSString *)description testCase:(XCTestCase *)test {
    if ((self = [super init])) {
        _threadDescription = [description copy];
        _testCase = test;
    }
    return self;
}

- (XCTestExpectation *)threadStarted {
    return [self.testCase expectationWithDescription:[self.threadDescription stringByAppendingString:@" started"]];
}

- (XCTestExpectation *)becameReader {
    return [self.testCase expectationWithDescription:[self.threadDescription stringByAppendingString:@" became reader"]];
}

- (XCTestExpectation *)finishedReading {
    return [self.testCase expectationWithDescription:[self.threadDescription stringByAppendingString:@" relinquished reader lock"]];
}

- (XCTestExpectation *)becameWriter {
    return [self.testCase expectationWithDescription:[self.threadDescription stringByAppendingString:@" became writer"]];
}

- (XCTestExpectation *)finishedWriting {
    return [self.testCase expectationWithDescription:[self.threadDescription stringByAppendingString:@" relinquished writer lock"]];
}

@end

@implementation PSPDFRecursiveReadWriteLockTests (Builder)

- (id<ExpectationBuilder>)newBuilderWithThreadDescription:(NSString *)format, ... {
    va_list arguments;
    va_start(arguments, format);
    let description = [[NSString alloc] initWithFormat:format arguments:arguments];
    va_end(arguments);

    return [[RWLockExpectationBuilder alloc] initWithThreadDescription:description testCase:self];
}

@end
