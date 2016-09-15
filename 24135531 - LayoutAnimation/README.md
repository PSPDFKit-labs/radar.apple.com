## Initial layout is caught in animation block when keyboard frame change is triggered when a view in a form sheet will appearing

http://openradar.appspot.com/24135531

Summary:
When a text field in a form sheet becomes or resigns first responder in `viewWillAppear:`, the initial view layout is caught in the animation block that moves the form sheet up or down. 

A sample project is attached that demonstrates the problem when becoming first responder (keyboard appearing). The case of resigning first responder is possibly worse because this is handled automatically by UIKit when a view disappears.

Steps to Reproduce:
Run the attached sample project full screen on iPad (regular or Pro, simulator or device) on iOS 9.

Page one (a cyan view) is presented in a form sheet.

Tap the cyan view to push page two, which has a text field that becomes first responder in `viewWillAppear:`.

Expected Results:
The initial view layout should not be animated. Page two should be laid out as soon as it appears.

Actual Results:
The elements on page two animate when they appear, popping from the top of the view. A dark grey view is provided to make this easier to see.

Version:
iOS 9.2 (13C75)

Notes:
Regression: does not happen on iOS 8.3, so appears to have been introduced in iOS 9.

Does not happen in compact widths where the form sheet is full screen.

Workaround: Become first responder in a `dispatch_async` block. Yuck. Maybe something similar can be done for resigning first responder when disappear but I have not tried yet.

Configuration:
iPad Air
