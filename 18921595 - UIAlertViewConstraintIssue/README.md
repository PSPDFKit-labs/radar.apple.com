## Unsatisfyable constraints when presenting UIAlertController

http://openradar.appspot.com/18921595

Summary:
Provide a descriptive summary of the issue.

Steps to Reproduce:
In numbered format, detail the exact steps taken to produce the bug.

Expected Results:
Open the attached project. It’ll explain things in more detail and show off the issue.
The second UIAlertController in style UIAlertControllerStyleActionSheet never shows up, only the dimming view does. The log is all over constraint issues.

Actual Results:
No sheet is showing up, but instead we have this in the log:
2014-11-09 21:56:22.948 UIAlertViewConstraintIssue[45380:3380118] Unable to simultaneously satisfy constraints.
	Probably at least one of the constraints in the following list is one you don't want. Try this: (1) look at each constraint and try to figure out which you don't expect; (2) find the code that added the unwanted constraint or constraints and fix it. (Note: If you're seeing NSAutoresizingMaskLayoutConstraints that you don't understand, refer to the documentation for the UIView property translatesAutoresizingMaskIntoConstraints) 
(
    "<NSLayoutConstraint:0x7fe3d0480eb0 H:[UIView:0x7fe3d0446b30(304)]>",
    "<NSLayoutConstraint:0x7fe3d0472270 _UIAlertControllerView:0x7fe3d04909a0'Constraint Issue'.width >= UIView:0x7fe3d0446b30.width>",
    "<NSLayoutConstraint:0x7fe3d0476cf0 _UIAlertControllerView:0x7fe3d04909a0'Constraint Issue'.width == UIView:0x7fe3d0491b30.width>",
    "<NSAutoresizingMaskLayoutConstraint:0x7fe3d049a880 h=--& v=--& H:[UIView:0x7fe3d0491b30(0)]>"
)

Will attempt to recover by breaking constraint 
<NSLayoutConstraint:0x7fe3d0480eb0 H:[UIView:0x7fe3d0446b30(304)]>


See the full log at https://gist.github.com/steipete/34de862cd5c71740201d


Regression:
Since this API is new, this never worked.

Notes:
Manually checking if the rect is too large and calculating the center point is a workaround, but this should be fixed in the framework.
