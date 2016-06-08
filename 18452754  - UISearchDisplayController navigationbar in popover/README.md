Summary:
UISearchDisplayController usually expands and hides the navigation bar when it is activated provided its content controller is the top view controller of the enclosing navigation bar. 

When however the navigation controller is presented in a popover, the navigation bar dismissal and re-appearance animation is broken.

Steps to Reproduce:
Run the example project on an iPad with iOS 7 or iSO 8. You can also take a look at the attached gif. 

Expected Results:
The navigation bar would move up when the search display controller expands and back down as it retracts back into its original position.

Actual Results:
The navigation remains stationary. The search bar is animated OVER the navigation bar when activated, and UNDER the navigation bar when search mode is exited.

Version:
iOS 7 and iOS 8, Xcode 6.0.1


Update: Still broken on 9.3.2, just differently now (status bar issues)