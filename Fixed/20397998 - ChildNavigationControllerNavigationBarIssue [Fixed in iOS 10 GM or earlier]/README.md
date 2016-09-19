## UINavigationBar erroneously shows extended apprarance when positioned at certain view coordinates

http://openradar.appspot.com/20397998

Summary:
We are adding a UINavigationController (containing a UINavigationBar) as a child view controller and showing the navigation controller view over part of the presenting controller view (half-modal appearance, see the screenshots in the attached archive). During this we noticed that if the view is positioned at certain (non-point-aligned?) coordinates, the UINavigationBar displays it’s extended size, as it were underneath the status bar in UIBarPositionTopAttached. This also happens if only pixel-aligning the coordinates (which is what we did). 

Steps to Reproduce:
Open and run the attached project. Follow the on screen instruction. The relevant code is in ViewController. 

Expected Results:
The UINavigationBar would show the extended appearance only when positioned at the top of the screen (underneath the status bar). 

Actual Results:
The UINavigationBar would show the extended appearance at certain coordinates. 

Regression:
iOS 8.2, iPhone 6 and iPhone 6 Plus.

Notes:
The workaround seems to be to always position the navigation controller view aligned to logical points (using integer values for the frame).
