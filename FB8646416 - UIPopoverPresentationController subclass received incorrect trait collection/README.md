## Custom subclass of UIPopoverPresentationController receives incorrect UITraitCollection when the app is backgrounded

**Feedback Reference:** FB8646416

**Summary:**
A custom subclass of UIPopoverPresentationController receives `UIUserInterfaceSizeClassCompact` for the `horizontalSizeClass` property of the new UITraitCollection received in the `willTransitionToTraitCollection:withTransitionCoordinator:` when the app is backgrounded while running in full screen width in landscape mode on the iPad (without any app open in split view).
The `horizontalSizeClass` of the new trait collections received should be `UIUserInterfaceSizeClassRegular` since the app is running in full screen width.
This issue can reproduced only while running on iOS 14. The `horizontalSizeClass` received while running the app on iOS versions prior 14 in the same conditions is as expected which is `UIUserInterfaceSizeClassRegular` and not `UIUserInterfaceSizeClassCompact` like on iOS 14.

**Steps to Reproduce:**
1. Open the attached `PresentationControllerTraitCollections` sample project.
2. Add a breakpoint in the `-[CustomPresentationController willTransitionToTraitCollection:withTransitionCoordinator:]` method in `CustomPresentationController.m` to inspect for the value of `horizontalSizeClass` of the new `UITraitCollection` received. Alternately, observe the console as the new trait collection object is logged.
3. Run the sample project app on an iPad Pro 12.9 Simulator in landscape mode running iOS 14 and ensure that no other app is running in split screen mode.
4. Tap on the "Present Controller" button to present a view controller in a popover using the custom popover presentation controller subclass – `CustomPresentationController`.
5. Now background the app and observe the value of `newCollection.horizontalSizeClass` received in the method where the breakpoint was set in Step 2.

**Expected:** 
The `horizontalSizeClass` should be `UIUserInterfaceSizeClassRegular` for the new `UITraitCollection` received in the `willTransitionToTraitCollection:withTransitionCoordinator:` method of the of our custom `UIPopoverPresentationController` subclass as the app is running in full screen width.

**Actual:**
`UIUserInterfaceSizeClassCompact` is received as the `horizontalSizeClass` for the new trait collections in the `willTransitionToTraitCollection:withTransitionCoordinator:` method.
This only happens while running the app on iOS 14. The expected values are received while running the app on version prior to iOS 14.

**Version:**
iOS 14, Xcode 12.0 beta 6 (12A8189n)
