Summary:
In certain circumstances, the UITableViewController size calculations are invalid.

How?
- The cell uses AutoLayout to calculate the size. Cell displays a multiline UILabel.
- UITableViewDelegate:
    - tableView:titleForHeaderInSection: returns nil
    - tableView:titleForFooterInSection: returns nil
    - tableView:heightForHeaderInSection: returns 0
    - tableView:heightForFooterInSection: returns 0

Steps to Reproduce:
1. Create UITableViewController with a single cell that uses multiline UILabel to display text. (see attached Xcode project)
2. Present view controller in portrait (fullscreen)
3. Rotate device to landscape
4. Rotate device back to portrait

Run attached project (Xcode 10) to reproduce the issue.

Expected Results:
After a step 4, the cell layout is equal to the layout from step 2

Actual Results:
After a step 4, the cell layout is different, the UILabel height is invalid.

Version/Build:
Xcode version 9.4 (9F1027a) - iOS 11.4
Xcode version 10.0 beta (10L176w) - iOS 12.0 beta 1

Configuration:
iPhone X - device and SimulatorApp-859.2 CoreSimulator-559
