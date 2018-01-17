# UIKeyboardAssistantBar tries to layout with a height of zero leading to unsatisfiable constraints

http://openradar.appspot.com/36578167

## Summary:
When a hardware keyboard is connected and the keyboard is active, then a view controller is pushed on the navigation controller, the `UIKeyboardAssistantBar` deep within UIKit can have its height set to zero. However it has subviews specifying constraints that require a certain amount of height. This leads to logging in the console about ‘Unable to simultaneously satisfy constraints’. Also if people have a breakpoint set on `UIViewAlertForUnsatisfiableConstraints` it will be triggered.

I’ve seen two slightly different situations leading to this but the underlying problem seems to be the same.

The unsatisfiable constraints are within the `UIRemoteKeyboardWindow`, in the bar with undo/redo etc (the only visible part of the keyboard when a hardware keyboard is connected). Here’s a snippet of the view hierarchy in that window:

```
<UIKeyboardImpl: 0x14e07b800; frame = (0 0; 1366 471); layer = <CALayer: 0x1c003fb40>>
   | <UIKeyboardAssistantBar: 0x14deabf00; frame = (0 0; 1366 0); tintColor = UIExtendedGrayColorSpace 0 1; animations = { position=<CABasicAnimation: 0x1c46237e0>; bounds.origin=<CABasicAnimation: 0x1c46238a0>; bounds.size=<CABasicAnimation: 0x1c46238c0>; }; layer = <CALayer: 0x1c423dec0>>
   |    | <_UIButtonBarStackView: 0x14deacf80; frame = (0 0; 187 55); clipsToBounds = YES; layer = <CALayer: 0x1c423df40>>
   |    |    | <_UIButtonBarButton: 0x14ddd8520; frame = (19 10; 41 36); layer = <CALayer: 0x1c0435860>>
```

There are unsatisfiable constraints for each button in the bar. They’re all like this:

`NSAutoresizingMaskLayoutConstraint:0x1c0484470 h=--& v=--& UIKeyboardAssistantBar:0x14deabf00.height == 0   (active)`

`V:|-(0)-[_UIButtonBarStackView]-(0)-|`
(superview is `UIKeyboardAssistantBar`)

`V:|-(10)-[_UIButtonBarButton]-(9)-|`
(superview is `_UIButtonBarStackView`)

So the buttons needs 10 points above and 9 below but can’t have that because the height of the containing bar is manually set to zero.

## Steps to Reproduce:
0. Run the attached sample project on iPad 10.5" (or any size of iPad). Device and Simulator both work.

1. Attach a hardware keyboard. (With a freshly launched Simulator I need to toggle the Connect Hardware Keyboard command off then on again to get into this state.)

2. Tap in the text field. You should see just the bar at the bottom with undo/redo etc, not the whole keyboard because a hardware keyboard is attached.

3. Tap the button to push a view controller.

## Expected Results:
The keyboard assistant bar should smoothly animate down off screen and there should be no unsatisfiable constraints so no logging in the console.

This can probably be achieved if UIKit either never sets the height of the `UIKeyboardAssistantBar` to zero, or hacks around these sorts of problems by setting up the constraints such that they are not required, typically by changing the priority of one constraint to 999.

## Actual Results:
The keyboard assistant bar disappears without animation and this stuff is logged: (stack trace below)

```
2018-01-17 10:02:40.301460+0000 Unsatisfied[1100:161150] [LayoutConstraints] Unable to simultaneously satisfy constraints.
	Probably at least one of the constraints in the following list is one you don't want. 
	Try this: 
		(1) look at each constraint and try to figure out which you don't expect; 
		(2) find the code that added the unwanted constraint or constraints and fix it. 
	(Note: If you're seeing NSAutoresizingMaskLayoutConstraints that you don't understand, refer to the documentation for the UIView property translatesAutoresizingMaskIntoConstraints) 
(
    "<NSAutoresizingMaskLayoutConstraint:0x1c0281310 h=--& v=--& UIKeyboardAssistantBar:0x151e1f280.height == 0   (active)>",
    "<NSLayoutConstraint:0x1c4094eb0 V:|-(0)-[_UIButtonBarStackView:0x151d277e0]   (active, names: '|':UIKeyboardAssistantBar:0x151e1f280 )>",
    "<NSLayoutConstraint:0x1c4094f00 V:[_UIButtonBarStackView:0x151d277e0]-(0)-|   (active, names: '|':UIKeyboardAssistantBar:0x151e1f280 )>",
    "<NSLayoutConstraint:0x1c0280dc0 'UIButtonBar.maximumAlignmentSize' UIView:0x151e0c9d0.height == UILayoutGuide:0x1c01be140'UIViewLayoutMarginsGuide'.height   (active)>",
    "<NSLayoutConstraint:0x1c008ce40 'UIView-bottomMargin-guide-constraint' V:[UILayoutGuide:0x1c01be140'UIViewLayoutMarginsGuide']-(9)-|   (active, names: '|':_UIButtonBarStackView:0x151d277e0 )>",
    "<NSLayoutConstraint:0x1c008c710 'UIView-topMargin-guide-constraint' V:|-(10)-[UILayoutGuide:0x1c01be140'UIViewLayoutMarginsGuide']   (active, names: '|':_UIButtonBarStackView:0x151d277e0 )>"
)

Will attempt to recover by breaking constraint 
<NSLayoutConstraint:0x1c008ce40 'UIView-bottomMargin-guide-constraint' V:[UILayoutGuide:0x1c01be140'UIViewLayoutMarginsGuide']-(9)-|   (active, names: '|':_UIButtonBarStackView:0x151d277e0 )>

Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
2018-01-17 10:02:40.315803+0000 Unsatisfied[1100:161150] [LayoutConstraints] Unable to simultaneously satisfy constraints.
	Probably at least one of the constraints in the following list is one you don't want. 
	Try this: 
		(1) look at each constraint and try to figure out which you don't expect; 
		(2) find the code that added the unwanted constraint or constraints and fix it. 
	(Note: If you're seeing NSAutoresizingMaskLayoutConstraints that you don't understand, refer to the documentation for the UIView property translatesAutoresizingMaskIntoConstraints) 
(
    "<NSAutoresizingMaskLayoutConstraint:0x1c0281310 h=--& v=--& UIKeyboardAssistantBar:0x151e1f280.height == 0   (active)>",
    "<NSLayoutConstraint:0x1c4094dc0 V:|-(0)-[_UIButtonBarStackView:0x151e1f560]   (active, names: '|':UIKeyboardAssistantBar:0x151e1f280 )>",
    "<NSLayoutConstraint:0x1c4094f50 V:[_UIButtonBarStackView:0x151e1f560]-(0)-|   (active, names: '|':UIKeyboardAssistantBar:0x151e1f280 )>",
    "<NSLayoutConstraint:0x1c0095e50 'UISV-canvas-connection' UILayoutGuide:0x1c01be3e0'UIViewLayoutMarginsGuide'.top == _UILayoutSpacer:0x1c01dd880'UISV-alignment-spanner'.top   (active)>",
    "<NSLayoutConstraint:0x1c0095b80 'UISV-canvas-connection' UILayoutGuide:0x1c01be3e0'UIViewLayoutMarginsGuide'.bottom == _UILayoutSpacer:0x1c01dd880'UISV-alignment-spanner'.bottom   (active)>",
    "<NSLayoutConstraint:0x1c40932e0 'UIView-bottomMargin-guide-constraint' V:[UILayoutGuide:0x1c01be3e0'UIViewLayoutMarginsGuide']-(9)-|   (active, names: '|':_UIButtonBarStackView:0x151e1f560 )>",
    "<NSLayoutConstraint:0x1c4093330 'UIView-topMargin-guide-constraint' V:|-(10)-[UILayoutGuide:0x1c01be3e0'UIViewLayoutMarginsGuide']   (active, names: '|':_UIButtonBarStackView:0x151e1f560 )>"
)

Will attempt to recover by breaking constraint 
<NSLayoutConstraint:0x1c0095b80 'UISV-canvas-connection' UILayoutGuide:0x1c01be3e0'UIViewLayoutMarginsGuide'.bottom == _UILayoutSpacer:0x1c01dd880'UISV-alignment-spanner'.bottom   (active)>

Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
2018-01-17 10:02:40.327275+0000 Unsatisfied[1100:161150] [LayoutConstraints] Unable to simultaneously satisfy constraints.
	Probably at least one of the constraints in the following list is one you don't want. 
	Try this: 
		(1) look at each constraint and try to figure out which you don't expect; 
		(2) find the code that added the unwanted constraint or constraints and fix it. 
	(Note: If you're seeing NSAutoresizingMaskLayoutConstraints that you don't understand, refer to the documentation for the UIView property translatesAutoresizingMaskIntoConstraints) 
(
    "<NSAutoresizingMaskLayoutConstraint:0x1c0281310 h=--& v=--& UIKeyboardAssistantBar:0x151e1f280.height == 0   (active)>",
    "<NSLayoutConstraint:0x1c4094e10 V:|-(0)-[_UIButtonBarStackView:0x151e05970]   (active, names: '|':UIKeyboardAssistantBar:0x151e1f280 )>",
    "<NSLayoutConstraint:0x1c4094e60 V:[_UIButtonBarStackView:0x151e05970]-(0)-|   (active, names: '|':UIKeyboardAssistantBar:0x151e1f280 )>",
    "<NSLayoutConstraint:0x1c02802d0 'UIButtonBar.maximumAlignmentSize' _UIButtonBarButton:0x151e46500.height == UILayoutGuide:0x1c41be4c0'UIViewLayoutMarginsGuide'.height   (active)>",
    "<NSLayoutConstraint:0x1c4090ae0 'UIView-bottomMargin-guide-constraint' V:[UILayoutGuide:0x1c41be4c0'UIViewLayoutMarginsGuide']-(9)-|   (active, names: '|':_UIButtonBarStackView:0x151e05970 )>",
    "<NSLayoutConstraint:0x1c4090540 'UIView-topMargin-guide-constraint' V:|-(10)-[UILayoutGuide:0x1c41be4c0'UIViewLayoutMarginsGuide']   (active, names: '|':_UIButtonBarStackView:0x151e05970 )>"
)

Will attempt to recover by breaking constraint 
<NSLayoutConstraint:0x1c4090ae0 'UIView-bottomMargin-guide-constraint' V:[UILayoutGuide:0x1c41be4c0'UIViewLayoutMarginsGuide']-(9)-|   (active, names: '|':_UIButtonBarStackView:0x151e05970 )>

Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
2018-01-17 10:02:40.336392+0000 Unsatisfied[1100:161150] [LayoutConstraints] Unable to simultaneously satisfy constraints.
	Probably at least one of the constraints in the following list is one you don't want. 
	Try this: 
		(1) look at each constraint and try to figure out which you don't expect; 
		(2) find the code that added the unwanted constraint or constraints and fix it. 
	(Note: If you're seeing NSAutoresizingMaskLayoutConstraints that you don't understand, refer to the documentation for the UIView property translatesAutoresizingMaskIntoConstraints) 
(
    "<NSAutoresizingMaskLayoutConstraint:0x1c0281310 h=--& v=--& UIKeyboardAssistantBar:0x151e1f280.height == 0   (active)>",
    "<NSLayoutConstraint:0x1c4094dc0 V:|-(0)-[_UIButtonBarStackView:0x151e1f560]   (active, names: '|':UIKeyboardAssistantBar:0x151e1f280 )>",
    "<NSLayoutConstraint:0x1c4094f50 V:[_UIButtonBarStackView:0x151e1f560]-(0)-|   (active, names: '|':UIKeyboardAssistantBar:0x151e1f280 )>",
    "<NSLayoutConstraint:0x1c0096cb0 'UISV-alignment' UIImageView:0x151e1f770.centerY == UIView:0x151d54950.centerY   (active)>",
    "<NSLayoutConstraint:0x1c0095e50 'UISV-canvas-connection' UILayoutGuide:0x1c01be3e0'UIViewLayoutMarginsGuide'.top == _UILayoutSpacer:0x1c01dd880'UISV-alignment-spanner'.top   (active)>",
    "<NSLayoutConstraint:0x1c0095b30 'UISV-canvas-connection' UILayoutGuide:0x1c01be3e0'UIViewLayoutMarginsGuide'.centerY == UIImageView:0x151e1f770.centerY   (active)>",
    "<NSLayoutConstraint:0x1c0094dc0 'UISV-spanning-boundary' _UILayoutSpacer:0x1c01dd880'UISV-alignment-spanner'.top <= UIView:0x151d54950.top   (active)>",
    "<NSLayoutConstraint:0x1c40932e0 'UIView-bottomMargin-guide-constraint' V:[UILayoutGuide:0x1c01be3e0'UIViewLayoutMarginsGuide']-(9)-|   (active, names: '|':_UIButtonBarStackView:0x151e1f560 )>",
    "<NSLayoutConstraint:0x1c4093330 'UIView-topMargin-guide-constraint' V:|-(10)-[UILayoutGuide:0x1c01be3e0'UIViewLayoutMarginsGuide']   (active, names: '|':_UIButtonBarStackView:0x151e1f560 )>"
)

Will attempt to recover by breaking constraint 
<NSLayoutConstraint:0x1c0094dc0 'UISV-spanning-boundary' _UILayoutSpacer:0x1c01dd880'UISV-alignment-spanner'.top <= UIView:0x151d54950.top   (active)>

Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
2018-01-17 10:02:40.342616+0000 Unsatisfied[1100:161150] [LayoutConstraints] Unable to simultaneously satisfy constraints.
	Probably at least one of the constraints in the following list is one you don't want. 
	Try this: 
		(1) look at each constraint and try to figure out which you don't expect; 
		(2) find the code that added the unwanted constraint or constraints and fix it. 
	(Note: If you're seeing NSAutoresizingMaskLayoutConstraints that you don't understand, refer to the documentation for the UIView property translatesAutoresizingMaskIntoConstraints) 
(
    "<NSAutoresizingMaskLayoutConstraint:0x1c0281310 h=--& v=--& UIKeyboardAssistantBar:0x151e1f280.height == 0   (active)>",
    "<NSLayoutConstraint:0x1c4094dc0 V:|-(0)-[_UIButtonBarStackView:0x151e1f560]   (active, names: '|':UIKeyboardAssistantBar:0x151e1f280 )>",
    "<NSLayoutConstraint:0x1c4094f50 V:[_UIButtonBarStackView:0x151e1f560]-(0)-|   (active, names: '|':UIKeyboardAssistantBar:0x151e1f280 )>",
    "<NSLayoutConstraint:0x1c00947d0 'UIButtonBar.maximumAlignmentSize' _UIButtonBarButton:0x151d5ace0.height == UILayoutGuide:0x1c01be3e0'UIViewLayoutMarginsGuide'.height   (active)>",
    "<NSLayoutConstraint:0x1c40932e0 'UIView-bottomMargin-guide-constraint' V:[UILayoutGuide:0x1c01be3e0'UIViewLayoutMarginsGuide']-(9)-|   (active, names: '|':_UIButtonBarStackView:0x151e1f560 )>",
    "<NSLayoutConstraint:0x1c4093330 'UIView-topMargin-guide-constraint' V:|-(10)-[UILayoutGuide:0x1c01be3e0'UIViewLayoutMarginsGuide']   (active, names: '|':_UIButtonBarStackView:0x151e1f560 )>"
)

Will attempt to recover by breaking constraint 
<NSLayoutConstraint:0x1c40932e0 'UIView-bottomMargin-guide-constraint' V:[UILayoutGuide:0x1c01be3e0'UIViewLayoutMarginsGuide']-(9)-|   (active, names: '|':_UIButtonBarStackView:0x151e1f560 )>

Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
```

---

This is the stack trace:

```
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 2.1
  * frame #0: 0x000000018f422140 UIKit`UIViewAlertForUnsatisfiableConstraints
    frame #1: 0x0000000185cc0be8 Foundation`-[NSISEngine handleUnsatisfiableRowWithHead:body:usingInfeasibilityHandlingBehavior:mutuallyExclusiveConstraints:] + 460
    frame #2: 0x0000000185c9efbc Foundation`-[NSISEngine fixUpValueRestrictionViolationsWithInfeasibilityHandlingBehavior:] + 576
    frame #3: 0x0000000185e6f000 Foundation`-[NSISEngine _optimizeWithoutRebuilding] + 288
    frame #4: 0x0000000185c9ece0 Foundation`-[NSISEngine optimize] + 132
    frame #5: 0x0000000185e6d034 Foundation`-[NSISEngine performPendingChangeNotifications] + 112
    frame #6: 0x000000018e926b98 UIKit`-[UIView(Hierarchy) layoutBelowIfNeeded] + 240
    frame #7: 0x000000018e949a68 UIKit`+[UIView(UIViewAnimationWithBlocks) _setupAnimationWithDuration:delay:view:options:factory:animations:start:animationStateGenerator:completion:] + 620
    frame #8: 0x000000018e960470 UIKit`+[UIView(UIViewAnimationWithBlocks) animateWithDuration:delay:options:animations:completion:] + 108
    frame #9: 0x000000018f66e904 UIKit`-[UIKeyboardAssistantBar setShow:] + 996
    frame #10: 0x000000018ed77448 UIKit`-[UIKeyboardImpl updateAssistantBar] + 508
    frame #11: 0x000000018e940f14 UIKit`-[UIKeyboardImpl setDelegate:force:] + 1192
    frame #12: 0x000000018e93a6dc UIKit`-[UIPeripheralHost(UIKitInternal) _reloadInputViewsForResponder:] + 1544
    frame #13: 0x000000018ebfa644 UIKit`+[UIView(Internal) _performBlockDelayingTriggeringResponderEvents:] + 516
    frame #14: 0x000000018ead9e80 UIKit`-[_UINavigationParallaxTransition animateTransition:] + 1112
    frame #15: 0x000000018ea98414 UIKit`-[UINavigationController _startCustomTransition:] + 3444
    frame #16: 0x000000018e9bac4c UIKit`-[UINavigationController _startDeferredTransitionIfNeeded:] + 712
    frame #17: 0x000000018e9ba890 UIKit`-[UINavigationController __viewWillLayoutSubviews] + 164
    frame #18: 0x000000018e9ba790 UIKit`-[UILayoutContainerView layoutSubviews] + 188
    frame #19: 0x000000018e911f00 UIKit`-[UIView(CALayerDelegate) layoutSublayersOfLayer:] + 1276
    frame #20: 0x00000001893a1998 QuartzCore`-[CALayer layoutSublayers] + 184
    frame #21: 0x00000001893a5b20 QuartzCore`CA::Layer::layout_if_needed(CA::Transaction*) + 332
    frame #22: 0x000000018931236c QuartzCore`CA::Context::commit_transaction(CA::Transaction*) + 336
    frame #23: 0x0000000189339b90 QuartzCore`CA::Transaction::commit() + 540
    frame #24: 0x000000018933a9d0 QuartzCore`CA::Transaction::observer_callback(__CFRunLoopObserver*, unsigned long, void*) + 92
    frame #25: 0x0000000185305edc CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__ + 32
    frame #26: 0x0000000185303894 CoreFoundation`__CFRunLoopDoObservers + 412
    frame #27: 0x0000000185303e50 CoreFoundation`__CFRunLoopRun + 1292
    frame #28: 0x0000000185223e58 CoreFoundation`CFRunLoopRunSpecific + 436
    frame #29: 0x00000001870d0f84 GraphicsServices`GSEventRunModal + 100
    frame #30: 0x000000018e97867c UIKit`UIApplicationMain + 236
    frame #31: 0x0000000100c22b80 Unsatisfied`main(argc=1, argv=0x000000016f1e39f0) at main.m:12
    frame #32: 0x0000000184d4056c libdyld.dylib`start + 4
```

## Version:
iOS 11.2 Xcode 9.2

## Notes:
In our project, this only happens when the view controller being pushed returns YES to canBecomeFirstResponder, which is needs to do for shake to undo support. The problem occurs with a different stack trace but both paths lead into an animation block in -[UIKeyboardAssistantBar setShow:].

Our workaround is to make sure we return NO to this method when the navigation controller tries to make the incoming view controller first responder, then after that change our response to YES and call becomeFirstResponder ourselves (which we have to do anyway in case the VC is not pushed but shown some other way).
