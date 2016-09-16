## UIAlertController based action sheet layout breaks in certain configurations

http://openradar.appspot.com/20020818

Summary:
UIAlertController in UIAlertControllerStyleActionSheet style exhibits auto layout issues when presented anchored to certain screen positions. 

Steps to Reproduce:
Open the provided example project and follow the on-screen instructions. 

Expected Results:
The popover would be positioned correctly, without any auto layout warnings. 

Actual Results:
The internal popover layout is broken and auto layout warnings a printed in the console. 

Regression:
The issue only seems to occur when the popover arrow is pointing left or right. A possible workaround is to restrict the possible arrow directions to up and down. 


Tested on iOS 10 GM, not fixed.
