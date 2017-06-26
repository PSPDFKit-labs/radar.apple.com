## Search bar moves out of frame when activated while background image is set on navigation bar

Number:	rdar://32980288	
Date Originated:	26-Jun-2017 04:36 PM
Status:	Open	
Product:	iOS + SDK	
Product Version:	iOS 9, 10, 11b2
Classification:	UI/Usability	
Reproducible:	Always

Summary:
When a background image is set on the navigation bar of navigation controller on the view controller where the search bar is added to a table header view, the search bar will move out of the frame of the view controller and is not visible on the screen anymore, when tapped and search will be started.

The background image on the navigation bar is set via UIAppearance as follows:
UINavigationBar.appearance().setBackgroundImage(UIImage(named: "NavigationBarBackground"), for: .default)

When the search bar is tapped, it usually hides the navigation bar and is moved to the top of the view controller. But when a background image is set on the navigation bar, the search bar will move out of the view bounds.

This happens because the frame origin of the search bars superviews will be set to a negative value, which is the cause for the search bar moving off screen.

A possible workaround is to manually show/hide the navigation bar when the search controller is presented/dismissed. This however messes with the animation when presenting/dismissing the search controller and doesn’t look as fluid. See SearchableViewController.swift in the attached sample.

The attached project uses child view controller containment to trigger the issue more reliably. See Notes.

Tested on iOS 9.0, 9.1, 10.3.2, 11b2 on device and Simulator.

Steps to Reproduce:
- Run the attached sample project
- Follow the steps on screen
- Notice that the search bar moves out of the views frame when tapped

Expected Results:
Search bar moves to the top edge of the view and stays visible.

Actual Results:
Search bar moves out of the views frame.

Version:
iOS 9, 10, 11b2

Notes:
This doesn't happen when definesPresentationContext set on the table view controller and there is no child view controller containment involved. When definesPresentationContext is not set, this also happens without child view controller containment.