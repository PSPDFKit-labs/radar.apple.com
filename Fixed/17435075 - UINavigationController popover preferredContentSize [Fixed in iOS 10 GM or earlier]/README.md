## UINavigationController no longer relays preferredContentSize changes

http://openradar.appspot.com/17435075

Summary:
In previous iOS versions, changing the preferredContentSize of a view controller that is the topViewController of a UINavigationController, which in turn is in a UIPopoverController, would cause the popover controller to resize. Similarly pushing a new view controller onto the UINavigationController stack, would cause the UINavigationController to resize, if it's content size was not large enough. This no longer happens with iOS 8.

Steps to Reproduce:
Build an run the attached PopoverContentSizeTest project. 
Run the example on iOS 7 and iOS 8 and compare the different popover sizing behaviors by pressing the various UIBarButton items. 

Expected Results:
The iOS 8 behavior should match more closely that of iOS 7. Ideally, popping the navigation controller would also shrink the popover, which does not occur automatically on neither OS version. 

Actual Results:
The popover controller does not resize on iOS 8. 

Version:
iOS 8, beta 2

Notes:

Configuration:
iPad
