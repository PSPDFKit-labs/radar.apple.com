## Crash when dismissing a popover under iOS 8.

http://openradar.appspot.com/18500786

Summary:
Under iOS 8, dismissing a popover might crash in an animation block after the object has been deallocated. This did work without any issues on iOS 7 and this is a regression.

Steps to Reproduce:
1. Open PopoverCrash app.
2. Run o Resizable iPad.
3. Observe a crash.

Note: Sometimes you need to try a bit, but it crashes in more than 80% of our tests - it *is* a bit timing dependent.

Expected Results:
No crash.

Actual Results:
Crash:

(lldb) bt all
* thread #1: tid = 0x13fc4e, 0x000000010d74b00b libobjc.A.dylib`objc_msgSend + 11, queue = 'com.apple.main-thread', stop reason = EXC_BAD_ACCESS (code=EXC_I386_GPFLT)
    frame #0: 0x000000010d74b00b libobjc.A.dylib`objc_msgSend + 11
    frame #1: 0x000000010e5a1a98 UIKit`__63-[UIPopoverPresentationController dismissalTransitionWillBegin]_block_invoke521 + 45
    frame #2: 0x000000010e5dba0e UIKit`-[_UIViewControllerTransitionCoordinator _applyBlocks:releaseBlocks:] + 217
    frame #3: 0x000000010e5d8d48 UIKit`-[_UIViewControllerTransitionContext _runAlongsideCompletions] + 123
    frame #4: 0x000000010e5d8ad3 UIKit`-[_UIViewControllerTransitionContext completeTransition:] + 126
    frame #5: 0x000000010de7d746 UIKit`__53-[_UINavigationParallaxTransition animateTransition:]_block_invoke93 + 687
    frame #6: 0x000000010def89f3 UIKit`-[UIViewAnimationBlockDelegate _didEndBlockAnimation:finished:context:] + 326
    frame #7: 0x000000010dee0d9a UIKit`-[UIViewAnimationState sendDelegateAnimationDidStop:finished:] + 209
    frame #8: 0x000000010dee10d0 UIKit`-[UIViewAnimationState animationDidStop:finished:] + 76
    frame #9: 0x000000011175899e QuartzCore`CA::Layer::run_animation_callbacks(void*) + 308
    frame #10: 0x000000010ffde7f4 libdispatch.dylib`_dispatch_client_callout + 8
    frame #11: 0x000000010ffc7991 libdispatch.dylib`_dispatch_main_queue_callback_4CF + 956
    frame #12: 0x000000010da03569 CoreFoundation`__CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ + 9
    frame #13: 0x000000010d9c646b CoreFoundation`__CFRunLoopRun + 2043
    frame #14: 0x000000010d9c5a06 CoreFoundation`CFRunLoopRunSpecific + 470
    frame #15: 0x00000001110509f0 GraphicsServices`GSEventRunModal + 161
    frame #16: 0x000000010de87550 UIKit`UIApplicationMain + 1282
  * frame #17: 0x000000010d2099b3 PopoverCrash`main(argc=1, argv=0x00007fff529f6548) + 115 at main.m:14
    frame #18: 0x0000000110013145 libdyld.dylib`start + 1

With Zombies:

*** -[_UIPopoverView layer]: message sent to deallocated instance 0x7f9eadc3bdb0

This only happens if we nil out the popover controller right after dismissing - however this should work as the documentation doesn't intend anything else.

Version:
iOS 8.0.2

Notes:


Configuration:
iPad Simulator
