Summary:
When a popover is presented such that it overlaps an active text selection inside UITextView, one or both of the drag handles for the text selection will be drawn above the popover. This is incorrect: the popover should — as the name suggests — be on top of all other content.

Steps to Reproduce:
1. Build and run the attached sample project
2. Follow the instructions on the screen

Expected Results:
The popover is displayed on top of any text selection.

Actual Results:
At least one of the drag handles is drawn on top of the popover’s content.

Version/Build:
Initially observed on iOS 12.2 (16E227) on an iPad Air 2 (Model A1567) reproduced on different iPad simulators.

Configuration:
