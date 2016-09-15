## UINavigationController offsets content for hidden UITabBar

http://openradar.appspot.com/21036145

Summary:

When adding a UINavigationController child view controller onto a view controller that previously hid the bottom UITabBar due to hidesBottomBarWhenPushed, the added  UINavigationController incorrectly adjusts it’s rootViewController for the hidden UITabBar. 

Steps to Reproduce:

Extract the example project. See the GIF to see the issue inside PSPDFKit. Than open the example project and follow the on screen instructions to reproduce the issue. 

You can set ENABLE_WORKAROUND  to 1 in PushedViewController.m to observe a possible workaround. 

Note: The demo does not reproduce the issue with the visual effect view turning black. That also seems related to hidesBottomBarWhenPushed.  

Expected Results:

The would be no extra space at the bottom of the table view. 

Actual Results:

Extra space is added at the bottom of the table view (content insets get adjusted). 

Regression:

iOS 8.3, iPhone. Perhaps also iPad.

Notes:

This bug report is based on a DTS. Follow-up: 622712635. See the response below. 

—

The cause of the tab bar sized sized gap when displaying the annotation view is that you're wrapping the PSPDFAnnotationStyleViewController in a navigation controller.  When the PSPDFNavigationController calculates the layout of its child view controller (PSPDFAnnotationStyleViewController) it sees that there is a tab bar controller present with a non-translucent tab bar, so it insets the frame of PSPDFAnnotationStyleViewController by the tab bar height.  The inner navigation controller does not check if the tab bar is hidden or if the containing view controller hidesBottomBarWhenPushed prior to insetting the frame of  PSPDFAnnotationStyleViewController.

Please file a bug report.  This will make the UIKit team aware of the issue so they can investigate the underlying cause.  It is actually much better for you (as a developer) if you file this bug.  You will be able to follow the status of the bug directly, where if I filed it, you would have to continually check in with me.

In the meanwhile, try this workaround:

1) Initialize PSPDFNavigationController with a nil view controller.
2) Set the toolbarHidden property of PSPDFNavigationController to NO.
3) Set the hidesBottomBarWhenPushed property of PSPDFAnnotationStyleViewController to YES.
4) Push PSPDFAnnotationStyleViewController onto the navigation controller (using -pushViewController:...animated:NO)
