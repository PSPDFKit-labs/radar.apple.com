## UINavigationBar exhibits visual glitch when pushing a view controller with hidesBottomBarWhenPushed enabled

http://openradar.appspot.com/21036226

Summary:

When a view controller with hidesBottomBarWhenPushed enabled is pushed onto a navigation stack that also contains a UITabBarController with a visible tabbar, the UINavigationBar (belonging to UINavigationController) exhibits a visual glitch. 

Steps to Reproduce:

Extract the attached archive. See the GIF that shows the issue on the iOS simulator. Open and run the provided sample project and follow the on screen instructions. 

Expected Results:

The navigation bar would not change color.

Actual Results:

During the animation, part of the navigation bar turns black.

Regression:

iOS 8, iPad and iPhone, also observable in the iOS simulator


Tested on iOS 10 GM, still broken.
