
UIViewController.presentationController is not updated if the transitioningDelegate returns a custom presentation controller
Originator:	aditya 	Modify My Radar
Number:	rdar://42996292 	Date Originated:	07-Aug-2018 11:53 AM
Status:	Open 	Resolved:	
Product:	iOS + SDK 	Product Version:	iOS 11.4.1
Classification:	Other Bug 	Reproducible:	Always

 
Summary:
UIViewController allows users to vend a custom presentation controller by means of the UIViewControllerTransitioningDelegate protocol. However, if the view controller’s presentation controller is accessed before setting the transitioning delegate, then the transitioningDelegate is never queried for the presentation controller. This results in unexpected behaviour.

Steps to Reproduce:
Run the attached sample project.

Expected Results:
The “Presentation controller now: %@“ line logs
“Presentation controller now: <CustomPresentationController: 0x123>”

Actual Results:
The “Presentation controller now: %@“ line logs
“Presentation controller now: <_UIFullscreenPresentationController: 0x123>”

Version:
iOS 11.4.1

Notes:
If you comment out line 30 (where the default presentationController is accessed), you will notice that the expected presentation controller is returned.
