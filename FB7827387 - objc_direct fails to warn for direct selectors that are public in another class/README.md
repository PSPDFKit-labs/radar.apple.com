# objc_direct fails to warn for direct selectors that are public in another class

objc_direct fails to warn for direct selectors that are public in another class.

Scenario:
- UIViewController exposes didReceiveMemoryWarning method
- Somewhere else a notification implements a private didReceiveMemoryWarning in an unrelated class
- PSPDF_OBJC_DIRECT_MEMBERS is applied
- Crash because notification selector is inlined. 

Reproduce: Start app, in Simulator go Debug -> Simulate Memory Warning.
Observe crash: Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[AppDelegate didReceiveMemoryWarning]: unrecognized selector sent to instance 0x600000d741a0'

Fix: rename selector to something unique.

This is tricky since the runtime probably really does not know; but it’s thinkable that additional logic is applied so that the common case ([NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didReceiveMemoryWarning)) is detected or warned about. 

I’m documenting this bug here and on https://pspdfkit.com/blog/2020/improving-performance-via-objc-direct/ to help others avoid it.
