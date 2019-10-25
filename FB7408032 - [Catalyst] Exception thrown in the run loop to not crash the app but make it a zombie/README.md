# FB7408032 - [Catalyst] Exception thrown in the run loop to not crash the app but make it a zombie



## Summary:
Run example. Press ‘Simple Alert’ a few times. Observe it shows an alert. Press “Tap to show ActionSheet”. Observe that an exception is thrown in the log.
Try pressing “Simple Alert” again. Observe that the app is broken, however it can still be interacted, fullscreen mode, resized, and if I had added a toolbar, that would work as well.

Exception is thrown here:

lldb) bt
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x00007fff66a04805 libobjc.A.dylib`objc_exception_throw
    frame #1: 0x00007fff6e9ad6a4 UIKitCore`-[UIPopoverPresentationController presentationTransitionWillBegin] + 3627
    frame #2: 0x00007fff6e9b8006 UIKitCore`__71-[UIPresentationController _initViewHierarchyForPresentationSuperview:]_block_invoke + 2623
    frame #3: 0x00007fff6e9b57a5 UIKitCore`__56-[UIPresentationController runTransitionForCurrentState]_block_invoke.463 + 554
    frame #4: 0x00007fff6e4c3d9c UIKitCore`_runAfterCACommitDeferredBlocks + 352
    frame #5: 0x00007fff6e4c3787 UIKitCore`_cleanUpAfterCAFlushAndRunDeferredBlocks + 248
    frame #6: 0x00007fff6e4c356b UIKitCore`_afterCACommitHandler + 85
    frame #7: 0x00007fff3092866e CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__ + 23
    frame #8: 0x00007fff30928594 CoreFoundation`__CFRunLoopDoObservers + 457
    frame #9: 0x00007fff308cb01e CoreFoundation`CFRunLoopRunSpecific + 558
    frame #10: 0x00007fff2f45267d HIToolbox`RunCurrentEventLoopInMode + 292
    frame #11: 0x00007fff2f4522c9 HIToolbox`ReceiveNextEventCommon + 356
    frame #12: 0x00007fff2f452147 HIToolbox`_BlockUntilNextEventMatchingListInModeWithFilter + 64
    frame #13: 0x00007fff2daea864 AppKit`_DPSNextEvent + 990
    frame #14: 0x00007fff2dae95d4 AppKit`-[NSApplication(NSEvent) _nextEventMatchingEventMask:untilDate:inMode:dequeue:] + 1352
    frame #15: 0x00007fff2dae3d76 AppKit`-[NSApplication run] + 658
    frame #16: 0x00007fff2dad595d AppKit`NSApplicationMain + 777
    frame #17: 0x00007fff2df56094 AppKit`_NSApplicationMainWithInfoDictionary + 16
    frame #18: 0x00007fff616bf731 UIKitMacHelper`UINSApplicationMain + 322
    frame #19: 0x00007fff6e4adba4 UIKitCore`UIApplicationMain + 2206
  * frame #20: 0x00000001000047ab ActionSheetCatalystIssue`main at AppDelegate.swift:12:7
    frame #21: 0x00007fff67d672e5 libdyld.dylib`start + 1
    frame #22: 0x00007fff67d672e5 libdyld.dylib`start + 1
(lldb) 

Expectation: App should crash If an exception is thrown, not become a zombie.
