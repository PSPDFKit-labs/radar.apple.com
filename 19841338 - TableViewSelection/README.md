## Regression: Selected Cells Not Highlighted Unless Table View Is Visible When Applying Selection

http://openradar.appspot.com/19841338

Summary:
On iOS 8, the selected cells of a UITableView no longer seem to be highlighted when they are selected while the table view is not on screen.
While this might not seem like a common scenario, this is exactly what happens during state restoration in a master/detail scenario:

Consider a navigation controller with two children — a UITableViewController, (master) and another UIViewController (detail). 

When you pop the detail off the navigation stack, the master becomes visible, and its default behavior (reloading the table in viewWillAppear:) will visibly clear the last selection, giving you context.

On iOS 7, (and if I remember correctly 6) this worked fine across state restoration boundaries:
you’re in detail, leave the app, app get’s killed after some time, you enter the app, state is restored*, you pop the detail, the cell that took you there goes from selected to not selected.

Because of the new behavior, this no longer is the case:
While the cell’s selection _is_, in fact, restored correctly, this is no longer visible.

Steps to Reproduce:
1. Build and run the attached sample on iOS 8 and iOS 7.
2. tap on a cell in the “master” tableview.
3. kill the app from the task switcher using the flick up gesture
4. restart the app — the state will be restored to the detail view controller
5. tap the back button and observe the cells in the table view

Expected Results:
On both, iOS 8 and 7, the cell you tapped to take you into the detail screen will be deselected in an animated fashion

Actual Results:
On iOS 7, this is exactly what happens. (good!)
On iOS 8, the scroll position of the tableview is restored correctly, but the cell does not appear highlighted at any time during the animated pop of the detail scene.

Version:
iOS 8.1 and 8.2 (beta)

Notes:
On 8.3 beta, state is never restored on the simulator so I don’t know how that would behave…

Configuration:
Any iOS 8 simulator will do, also iPad air 2 and iPhone 5