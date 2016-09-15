## Can’t do two view controller transitions at the same time

http://openradar.appspot.com/22565398
 
Summary:
We display inspector views either in popovers or with a custom UIPresentationController subclass that slides the view up to cover the bottom half of the screen — similar to iWork. Some interactivity with the content underneath is allowed while the inspector is shown.

The navigation bar back button can be tapped while inspector is shown, and the interactive back gesture also works. We want to dismiss the inspector when going back, so we need to do two view controller transitions at the same time. This does not seem to be supported.

Ideally, the two transitions would be coordinated, so when the interactive back gesture is taking place, the inspector would dismiss in-sync.

To summarise the setup:

1. A pushes B
2. B presents C non-modally
3. User pops B

Steps to Reproduce:
1. Open and run the attached sample project on an iPad (so the popovers are really popovers).
2. Tap the detail view controller to show a popover.
3. Go back, either with the back button or by swiping from the left screen edge.
4. Change the pre-processor conditionals in viewWillDisappear: in DetailViewController.m to try different setups.

Expected Results:
Hoping for a way to run a view controller transition alongside another view controller transition, so we can reuse standard modal transition styles or our animation controllers.

Actual Results:
If we try to animate dismissal in viewWillDisappear:, the transition is deferred until after the pop.

We can work around this by disabling dismissal animation, but it looks bad.

A more sophisticated workaround is to grab the presentation controller’s container view and do a UIView animation (not a view controller transition) alongside the pop transition, then dismiss the view controller after the transition finishes (at which point it is already hidden). The sample project simply sets the alpha to zero, effectively reimplementing UIModalTransitionStyleCrossDissolve. This feels like the responsibilities are in the wrong place.

Version:
iOS 9 beta 5, Xcode 7.0 beta 6 (7A192o)

Notes:


Configuration:
iPad Air, iPad Air 2 simulator
