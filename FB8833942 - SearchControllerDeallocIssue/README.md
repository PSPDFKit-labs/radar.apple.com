# FB8833942: UISearchController creates a retain cycle unless explicitly dismissed

SThe view controller of the search controller is not deallocated if it is dismissed while search is active.
See example for details.

In our code, he _UISearchPresentationController holds a strong reference to the presented view controller.
In this simpler example it seems to just be a notification.
Variants of this bug exist since iOS 10. https://github.com/larryryu/SearchControllerBug

Fix is to manually dismiss the search controller, but this is nowhere documented and hard to enforce

Twitter investigation thread: https://twitter.com/steipete/status/1321535951886319618?s=21

Still an issue with iOS 14.2b3
