## Presentation controller container view is not an ancestor of the presenting view controller’s view

http://openradar.appspot.com/22394135

Summary:
A UIPresentationController’s `containerView` is documented to be ‘ancestor of both the presenting and presented view controller's views’. This is not the case, and therefore non-modal presentation are challenging (where the user can still interact with the presenting view).

Steps to Reproduce:
1. Open the attached sample project
2. Run it
3. Tap to present a view controller

Expected Results:
The documentation to be consistent with what happens. Either for the container view to be an ancestor of the presenting view (somehow) or for the documentation to state this is not the case.

Actual Results:
The container view is not an ancestor of the presenting view controller’s view, only the presented view controller’s view.

Version:
iOS 9 beta 5

Notes:


Configuration:
iPhone 6 Plus simulator
