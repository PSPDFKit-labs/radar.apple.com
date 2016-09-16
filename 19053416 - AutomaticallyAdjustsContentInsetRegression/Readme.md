## automaticallyAdjustsScrollViewInsets doesn't work when view controllers are switched.

http://openradar.appspot.com//19053416

Summary:
automaticallyAdjustsScrollViewInsets doesn't work when view controllers are switched.
In this example we use transitionFromView:toView:duration:options:completion: to toggle between view controllers. (We’re not using the transitionFromViewController: API to have a more fine-grained control over certain animation aspects that are not visible in that radar).

Only through Hopper and some UIKit disassembling I found a public workaround to re-trigger the automaticallyAdjustsScrollViewInsets on the new content. This should be triggered automatically when views change.

Steps to Reproduce:
Open the AutomaticallyAdjustsContentInsetRegression example. Follow the guide in it, an alert explains the details.

Expected Results:
contentInset correctly set on the second controller.

Actual Results:
contentInset not set, unless we manually trigger updating.

Regression:
This wasn’t a focus-point of the example, but in the complex example I have in PSPDFKit this works well on iOS 7, but broke in 8. I didn’t managed to reproduce it in the exact same way in the radar, but this seems like a bug in 8 as well.

Notes:
Check the code for the workaround in ContainerViewController.m

Tested on iOS 10 GM, not fixed.
