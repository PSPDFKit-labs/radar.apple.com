## UI frozen after rotating due to animation completion handler not called

http://openradar.appspot.com/25337014

Summary:
In UIView based animations an animation’s completion handler is not called reliable. You can easily break that by calling -[UIView actionForLayer:forKey:] within an animation block.
What is even worth is: If you happen to call this inside your layout code, this will get executed within a window rotation. This results in rotation being broken (no rotation possible after this) and the UI being completely unresponsive as the rotation animation isn’t cleaned up (-[UIApplication isIgnoringInteractionEvents] is still YES after the animation).

Steps to Reproduce:
0. Open the attached sample project
1. Tap the ‘animate’ button and notice that after the animation an alert is shown.
2. Switch the ‘break animation’ switch to on
3. Tap the ‘animate’ button again
4. Rotate the device
5. Try to interact with the ‘animate’ button or the switch
6. Try to rotate the device

Expected Results:
- After step 3 the alert is shown again.
- Step 5 works and you can still trigger the animation and toggle the switch
- Sept 6 works and the UI rotates alongside the device.

Actual Results:
- After step 3 no alert is shown. In fact the animation’s ‘completionHandler’ is never called.
- Step 5 is not working. User interactions are not interpreted due to -[UIApplication isIgnoringInteractionEvents] returning YES.
- Step 6 is not working either. Inside the rotation code, the key window returns YES when asked for -[UIWindow isInterfaceAutorotationDisabled]

Regression:
This can be tested on simulator as well as device. Verified on iOS 8.4 Simulator, iOS 9.3 Simulator, iPad 3rd Gen. running iOS 9.3.

Notes:
The rotation issue already arises during the first rotation. The second try only illustrates what happened. When rotating the first time (Step 4) `-[UIViewController window:didRotateFromInterfaceOrientation:oldSize:]` is never called. As far as I can tell this is because this method is invoked inside an animations completion handler, which is never called for the same reason as no alert is shown after Step 3: By calling `[self.view actionForLayer:self.view.layer forKey:@"position”]` inside `viewDidLayoutSubviews` in the sample project, this gets executed within the rotation animation block and breaks it.

Update: Still broken in 9.3.2
