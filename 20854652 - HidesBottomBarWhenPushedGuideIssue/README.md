## Bottom layout guide is too long while pushing a view controller with the hidesBottomBarWhenPushed option

http://openradar.appspot.com/20854652

Summary:

When pushing a view controller with hidesBottomBarWhenPushed onto a view controller stack made up of a root UITabBarController and and a UINavigationController, the bottom layout guide for the pushed view controller stays set to the value representing the now hidden tabbar. This happens despite the transition never actually showing the tabbar on the pushed view (the tabbar gets overlaid by the pushed view). 

Steps to Reproduce:

Open the attached sample project and run it on an iPhone or iPad follow the on-screen instructions. Observe the red view on the pushed view controller. This view is anchored to the bottomLayoutGuide

Expected Results:

The red view would be positioned at the very bottom of the view even during the push transition.

Actual Results:

The red view is positioned as if it was above the tabbar, despite the fact the the tabbar is no longer visible. 

Regression:

iOS 8.3, iPhone, iPad and iOS simulator, happens on previous iOS 8 versions as well. Does not happen on iOS 7. 

Notes:

ViewController.m has some useful loging that you should be able to see in the console.
