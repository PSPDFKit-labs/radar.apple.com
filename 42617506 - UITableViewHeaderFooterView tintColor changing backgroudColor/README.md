### UITableViewHeaderFooterView tintColor changes it's backgroundView's backgroudColor

https://openradar.appspot.com/42617506

Summary:
When using UIAppearance to set the tintColor of a UITableViewHeaderFooterView, the backgroundColor of the backgroundView of UITableViewHeaderFooterView also changes to the set tintColor.

Steps to Reproduce:
Attached project illustrates the behaviour.

Expected Results:
The backgroundColor of the backgroundView of UITableViewHeaderFooterView changes to the tintColor with an alpha of 0.9

Actual Results:
Setting the tintColor of UITableViewHeaderFooterView should only set the tintColor of the itself and the backgroundView object and not change the backgroundColor.

Version:
11.4