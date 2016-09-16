## Accessing popoverPresentationController creates a retain cycle.

http://openradar.appspot.com//19167124

Summary:
Accessing popoverPresentationController creates a retain cycle. UIPopoverPresentationController is strongly saved in the content view controller. Then the UIPopoverPresentationController strongly references the view controller.

Steps to Reproduce:
Open example. Set breakpoint to PSPDFTestViewController’s dealloc. It’s not being called.

Expected Results:
No retain cycle. PSPDFTestViewController should deallocate.

Actual Results:
In the example, both PSPDFTestViewController instances stay in memory, forever, with their matching UIPopoverPresentationController.

Regression:
This API did not exist on iOS 7.

Notes:
Tricky to decide where the retain cycle should be broken. I understand why UIPresentationController retains both view controllers for the presentation animation. If UIPopoverPresentationController would have used composition, the creation/destruction of the internal presentation controller could be managed. But we can’t change the API now, so I suggest a private extension that doesn’t yet set presentedViewController (as presentingViewController also is set dynamically when the presentation actually happened.)

BTW: UIPopoverPresentationController is a new API, but it’s delegate is assign, not weak?



Update July 9, 2016:

Tested on iOS 9.3.2, not fixed.
Tested on iOS 10.0 GM, not fixed.
