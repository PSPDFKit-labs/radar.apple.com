XCTTest is not thread safe. Reproducible -[XCTWaiter release]: message sent to deallocated instance
Originator:	steipete	
Number:	rdar://35271380	Date Originated:	31-Oct-2017 03:16 PM
Status:	Open	Resolved:	
Product:	Developer Tools	Product Version:	9.0.1 (9A1004)
Classification:	Crash/Hang/Data Loss	Reproducible:	Sometimes
 
Summary:
We’ve noticed an instability in our CI setup and sporadic crashes mostly around testing a new custom lock implementation. The crashes are sporadic over-releases in the com.apple.dt.async-test-expectation on XCTWaiter. 

Steps to Reproduce:
Run tests on sample app.
Re-run until crash is triggered.

Ensure Zombies are enabled (they are in the provided sample) to correctly break.

Expected Results:
XCT* should be well-tested and thread safe.

Actual Results:
When enabling Zombies it sometimes crashes on *** -[XCTWaiter release]: message sent to deallocated instance 0x61800001ab30

Note that several test run attempts will be needed as it is a race condition.
Use iPad Air, iOS 10.3.1 for best results.

Version:
9.0.1 (9A1004)

Notes:
My kingdom for a workaround! 

If you have trouble reproducing, you can also run it in the console via xcodebuild test -scheme XCTThreadSafety -destination "platform=iOS Simulator,name=iPad Air,OS=10.3.1" - eventually after enough launches you’ll see the “Restarting after unexpected exit or crash in PSPDFRecursiveReadWriteLockTests/testDeniesConcurrentWriters; summary will include totals from previous launches.” and it yields a crash report. I found Xcode more convenient though. Screenshot of crash state is included as well.

The sample is slightly messy because I already spent half a day getting it into a state where it can be relatively easily reproduced - afraid that removing further tests might make it harder to repro. In theory the testDeniesConcurrentWriters alone should be all you need.

And yes, we know that the lock is a… discussable workaround. Let’s focus on the crash :)

I was able to reproduce this in Xcode 9.1b2 (9B46) as well.