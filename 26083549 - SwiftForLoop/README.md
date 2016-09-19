## Swift 2.2 Fix-It broken when it comes to for loop - appears non deterministic

http://openradar.appspot.com/26083549

Summary:
In Xcode 7.3.1 / Swift 2.2 the fix-it is broken when it comes to the old style for loops.

Steps to Reproduce:
0. Open the sample playground.
1. Click the yellow advise on how to update the for loop
2. Click the now appearing red compiler error
3. Repeat step 2 a couple of times

Expected Results:
After step 1 there is no other warning / error in that line.

Actual Results:
While repeating step 3, sometimes Xcode tries to add another comma do fix the issue and sometimes it tries to remove one. This looks like as if the Swift syntax parser is non deterministic in its behavior.

Tested with Xcode 8/Swift 3, not fixed.
