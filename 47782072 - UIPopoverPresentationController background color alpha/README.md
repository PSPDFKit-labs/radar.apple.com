### Changing UIPopoverPresentationController's backgroundColor after presentation makes the popover content disappear

https://openradar.appspot.com/47782072

#### Summary:
While using a UIPopoverPresentationController to show a view controller as a modal popover, the popover contents are not visible/disappear after the size class of the device changes post its presentation and the popover controller background color is set after the popover presentation is carried out.

#### Steps to Reproduce:
- Open the attached example app, PopoverControllerBackgroundColor, and run it on iPad in split view (50:50) with another app that supports landscape.
- Make sure the device is in portrait mode.
- Tap on the button “Show Popover”.
- Rotate the device to landscape mode once the popover is visible for forcing size class change.

#### Expected Results
The presented popover with its contents, that is the presented view controller, should be visible and have the appropriate background color.

#### Actual Results
The popover is visible however the contents of the popover, the presented view controller, is not visible.
Check the view hierarchy using the debugger, the presented view controller is laid out properly and is visible but the UIPopoverController’s view wrapper over the content view has an alpha of 0 because of which the content is invisible.

#### Version
12.1

#### Notes
This issue does not occur when the backgroundColor is set before the call to present the view controller has been made. However this becomes a limitation for implementations where the `backgroundColor` relies on certain conditions or calculations whose results are available after the presentation has been completed.

There is another workaround which is to subclass UIPopoverPresentationController and override -[UIPresentationController presentationTransitionWillBegin] to manually set the alpha of the view to 1 as below:
`self.presentViewedController.view.superview.alpha = 1.f;`