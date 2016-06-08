The visual debugger fails because of an assertion in UIKit's UITextView when auto layout is not used.

Steps to Reproduce:
Run sample in Xcode 7.3. Select view debugger. Observe assertion in the log and no working view debugger.

2016-03-23 10:05:17.963 AutoLayoutViewDebuggingIssue[83786:1782898] *** Assertion failure in -[UITextView _firstBaselineOffsetFromTop], /BuildRoot/Library/Caches/com.apple.xbs/Sources/UIKit_Sim/UIKit-3512.60.7/UITextView.m:1683

Expected Results:
View debugger should work. Nothing should throw up in the log.

Actual Results:
Sadness. No view debugger. Me going back to Reveal, then getting curious and spending an hour on this radar :)

Regression:
This used to work, could be a regression in Xcode 7.3 OR in UIKit 9.3? I’ve checked my decompiles for UIKit and it doesn’t seem like it’s a recent UIKit change, so pretty sure it’s a recent Xcode change instead.

Notes:
See my workaround in ViewController.m via adding useless constraints to satisfy the check in the method that asserts. Rather not do that but don’t see another way.

Still broken in Xcode 7.3.1