Area:
UIKit

Summary:
Sending `reloadData` to a table view within `setEditing:animated:` of one of
it's cells crashes in `setEditing:animated:` of the corresponding table view
controller.

Steps to Reproduce:
1. Open `EditingCrashExample` project
2. Build & Run
3. Tap Edit
4. Tap in one of the text fields to begin editing
5. Tap Done

Expected Results:
Exception with a descriptive message, something like "`reloadData` called while
`setEditing:animated:` in progress".

Observed Results:
Obscure range exception, stack trace doesn't reveal the problem.

Version:
iOS 10.3

Notes:
-

Configuration:
-