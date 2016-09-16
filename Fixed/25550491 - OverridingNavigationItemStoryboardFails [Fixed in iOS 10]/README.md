## Custom UINavigationItem is ignored if ViewController is initialized via Storyboard

http://openradar.appspot.com/25550491

Summary:
When overriding `-[UIViewController navigationItem]` as documented and returning a custom navigation item, that item is ignored if the view controller is instantiated in a storyboard as the root view controller of a navigation controller.Pushing it from inside a storyboard works as expected.

Steps to Reproduce:
0. Open the attached sample project.
1. Run it.
(2. Have a look in ViewController.m)

Expected Results:
The navigation bar shows a bar button item with the title ‘Test’ on the right side.

Actual Results:
The navigation bar has no items at all.

Regression:
This issue does not occur if the view controller in question is pushed onto a navigation controller. It doesn’t matter if it is the result of a storyboard segue or a programatic call to `pushViewController:animated:`. It works in both cases.

Notes:
The documentation is a little vague is it only states ‘To ensure the navigation item is configured, you can either override this property and add code to create the bar button items when first accessed or create the items in your view controller's initialization code.’
It is unclear to me if overriding also means returning an instance of `UINavigationItem` that I created myself, but that is how I understand that. If this is not what this means that please treat this radar as a) a bug report for the documentation and b) a request that having custom navigation items should be possible. As it already works in almost all cases, it may already be fixed by asking for `navigationItem` while being initialized through a coder instead of directly accessing the internal ivar.

Open Radar Sample Code can be found here:
https://github.com/PSPDFKit-labs/radar.apple.com/tree/master/25550491%20-%20OverridingNavigationItemStoryboardFails

Fixed in iOS 10 GM.
