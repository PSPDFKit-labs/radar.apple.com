Originator:	matej
Number:	rdar://27074874
Date Originated:	29-Jun-2016 09:21 AM

Action sheets shown on a popover-presented controller do not preserve their position after rotation

Summary:

When showing a UIAlertController with the UIAlertControllerStyleActionSheet style on a UIViewController that is presented as a popover, the action sheet arrow no longer points at the correct view after rotation. This only happens when reseting the action sheet over a popover-presented controller. 

Steps to Reproduce:

Run the provided example project on an iPad (or iPad simulator). Follow the on screen instructions.

Expected Results:

The action sheet would point to the sourceView / rect before and after rotation. Just like the main popover points to the same location. 

Actual Results:

The action sheet arrow is offset after rotating and no longer points at the sourceView. See the attached screenshots for details. 

Regression:

iPad, iOS 8, 9 and 10 beta1

Notes:

After investigating the issue, it seems that the sourceView is not yet updated to the correct position when the action sheet gets the opportunity to lay out its position after rotation. The correct position for the sourceView is only becomes available in the next run loop iteration. 
