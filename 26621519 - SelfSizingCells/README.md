## Default table view cells don't size properly

http://openradar.appspot.com/26621519

Summary:
When using self sizing table view cells together with UIKit’s default table view cells, they don’t size correctly. They also change their size while scrolling.

Steps to Reproduce:
0. Open the attached sample project
1. Run on iPad
2. Tap on ‘Open Popover’

Expected Results:
The distance from text to separator line should be the same for all cells, top and bottom.
Text should be fully visible.

Actual Results:
Text is fully visible.
Notice that some lines of text are very close to the separator lines as their size is too small.

Regression:
It seems that this happens more often when inside a popover and when having an image set, but can also be seen when having a table view without images and first scroll down and then back up. While scrolling up, the scroll view jumps.

Notes:
I also attached a Screencast where the issue can be seen. Note the wrongly positioned text label and also the jumping while scrolling through the table view!

Tested on iOS 10 GM, not fixed.
