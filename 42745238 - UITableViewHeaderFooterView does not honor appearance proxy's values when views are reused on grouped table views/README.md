Summary:
We support theming in our application, and noticed that the colors for the headers and footers in our table view were colored incorrectly.

After much digging into our code, we realized that when a UITableView is created with a UITableViewStyleGrouped, the default UITableViewHeaderFooterView implementation does not respect the appearance proxy after the views are reused. That is, after the UITableViewHeaderFooterView, the textLabel's textColor property is reset to its default value.

If the table view is created with UITableViewStylePlain, the table view behaves correctly setting the label's text color to the correct value based on the UIAppearance proxy implemented.

The label color's are set using this code:

        [UILabel appearanceWhenContainedInInstancesOfClasses:@[UITableViewHeaderFooterView.self]].textColor = UIColor.redColor;

This code does not work:

        [UITableViewHeaderFooterView appearance].textLabel.textColor = UIColor.redColor;

Steps to Reproduce:
1. Download the sample project attached, and run it in the simulator.
2. Interact with the table view, scrolling up and down.
3. Notice how the titles' and footers' colors change from red to their default value, ignoring the values set through the appearance proxy.

Expected Results:
The appearance value is honored even when the views are reused and the table view is using UITableViewStyleGrouped.

Actual Results:
The appearance value for the text color is ignored after the UITableViewHeaderFooterView view is reused with the table view using UITableViewStyleGrouped.

Version:
11.4

Notes:
