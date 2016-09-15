## State Restoration Broken on Simulator in Xcode 6.3beta 1

http://openradar.appspot.com/19812320

Summary:
The attached sample project that was created for rdar://19810729 does not restore any state when run in the simulator on Xcode 6.3 beta 1.

Steps to Reproduce:
1. Build and run the attached sample on Xcode 6.3 beta 1
2. set up some state and kill the app through the launcher, so that state restoration info is written.
3. restart the app

Expected Results:
You start where you left off, everything is fully functional, all data present

Actual Results:
You see the launch image, no state is restored, whatsoever.
If you set any breakpoints in the app delegate callbacks they are not hit, even though the serialization callbacks have all been called during app shutdown.

Version:
Xcode Version 6.3 (6D520o)
Simulator Version 8.3 (SimulatorApp-565.6 CoreSimulator-117.13)

Notes:


Configuration:
Does not happen on Xcode 6.1.1 (6A2008a) or its simulators.
Does not happen on Xcode 6.2 (6C121) or its simulators
Does not happen when built on Xcode 6.3 (6D520o) but run on hardware running 8.1.3 (12B466)


## State Restoration Breaks Unwind on Phone for Presented View Controllers

http://openradar.appspot.com/19810729

Summary:
While building a reduced sample to hunt a problem with restoration of a presented view controller, I ran into the following issue:

When a view controller is presented using a segue, and dismissed using an unwind segue, it is impossible to dismiss the view controller after state restoration on the phone.
On iPad, the issue can be mitigated by setting `definesPresentationContext` of the master’s navigation controller to `YES` and the `modalPresentationStyle` to `currentContext` but on the phone, that navigation controller will not be in the hierarchy.
Attempting to work around that issue by setting `definesPresentationContext` of another view controller to `YES` might result in the presentation to occur in a way, that the presented navigation controller’s bar is positioned under the other navigation bar.

Steps to Reproduce:
iPad:
1. Build and run the attached sample project on the iPad (simulator).
2. tap the “+” button several times, and select one row.
3. tap the “Do something” bar button item — a new navigation controller is presented over the detail navigation controller.
4. verify that both bar button items, “Dismiss Me” and “Unwind” dismiss the presented controller.
5. tap “Do something” once more, and kill the app using the launcher, in order to get state restoration.
6. Launch again, and verify that the “unwind” bar button item works in the freshly restored state.

iPhone
1. Build and run the attached sample project on the iPhone (simulator).
2. tap the “+” button several times, and select one row.
3. tap the “Do something” bar button item — a new navigation controller is presented over the detail navigation controller.
4. verify that both bar button items, “Dismiss Me” and “Unwind” dismiss the presented controller.
5. tap “Do something” once more, and kill the app using the launcher, in order to get state restoration.
6. Launch again, and tap the “Unwind” button.

Expected Results:
On both kinds of devices, tapping the “Unwind” button in step 6 dismisses the presented view controller after state restoration.

Actual Results:
On the phone, you will find yourself stuck in the presented view controller, unless you tap on the “Dismiss me” bar button item.
Afterwards, almost everything works as expected (apart from the fact that the previously selected cell is not un–highlighted on pop back to the root of the navigation stack, but that’s another issue…)

Version:
Xcode Version 6.1.1 (6A2008a) and included iOS 8.1 SDK

Notes:
On Xcode beta 6.3 State restoration appears to be completely borked:
State is saved, but not restored on the simulator (and I’m not putting 8.3 on a device soon)

Configuration:
Any iOS 8 simulator will do, also iPad air 2
