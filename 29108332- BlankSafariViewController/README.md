### Blank SFSafariViewController

http://www.openradar.me/29108332

Summary:
When you create SFSafariViewController during controller presentation and then later try to present that SFSafariViewController, then the presented SFSafariViewController is blank.

Steps to Reproduce:
See attached sample project.

Expected Results:
Presented SFSafariViewController should be properly presented.

Actual Results:
Presented SFSafariViewController is blank.

Notes:
Looks like the underlying SFSafariViewController remote child view controller is not added to the window.
