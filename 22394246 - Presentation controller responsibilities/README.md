## Presentation controller responsibilities

http://openradar.appspot.com/22394246

Summary:
This is a proposal about API design. You probably have better insight into this than I do.

I am assuming adaptivity between arbitrary presentation controllers is possible. See bug 22394182. (We currently do this by dismissing and re-presenting when the size or trait collection changes.)

Steps to Reproduce:
Try to do something cool with presentation controller adaptivity.

Expected Results:
I think adaptivity should be the responsibility of a different object to the presentation controller, possibly the transitioning delegate (which is the object originally responsible for choosing the presentation controller). The benefit of this is that the presentation controller is only responsible for managing its own presentation.

Actual Results:
In UIKit, view controller presentation adaptivity is the responsibility of the presentation controller (even if it delegates this it comes back to the presentation controller).

As it currently is, you provide a primary presentation controller which then provides other presentation controllers for adaptivity. This feels odd, because the decision about which is primary is arbitrary.

Version:
iOS 9 beta 5

Notes:
I attached diagrams showing how I view the current chain of object creation, and my proposed change. (I only show two presentation controllers, but there could be more.)
