## UISplitViewController doesn't dismiss it's master popover on dismissal.

http://openradar.appspot.com/20962645

Summary:
UISplitViewController uses an internal popover to slide the sidebar in. This popover is not dismissed when the view controller gets dismissed.

Steps to Reproduce:
Open example. Follow instructions in alert view. Observe crash:

*** Terminating app due to uncaught exception 'NSGenericException', reason: '-[UIPopoverController dealloc] reached while popover is still visible.'
*** First throw call stack:
(
	0   CoreFoundation                      0x00000001050eac65 __exceptionPreprocess + 165
	1   libobjc.A.dylib                     0x0000000104d81bb7 objc_exception_throw + 45
	2   CoreFoundation                      0x00000001050eab9d +[NSException raise:format:] + 205
	3   UIKit                               0x0000000105abd5ec -[UIPopoverController dealloc] + 137
	4   libobjc.A.dylib                     0x0000000104d9628e _ZN11objc_object17sidetable_releaseEb + 236
	5   UIKit                               0x000000010592a196 -[UISplitViewController dealloc] + 293
	6   CoreFoundation                      0x0000000104fc08eb CFRelease + 603
	7   CoreFoundation                      0x0000000104fdf4de -[__NSArrayI dealloc] + 78
	8   libobjc.A.dylib                     0x0000000104d9628e _ZN11objc_object17sidetable_releaseEb + 236
	9   libobjc.A.dylib                     0x0000000104d968cd _ZN12_GLOBAL__N_119AutoreleasePoolPage3popEPv + 591

Expected Results:
Should dismiss the popover.

Actual Results:
Crashes.

Notes:
Hack/Workaround is in the example, see backToCatalog. I know that UISplitViewController is supposed to be root, but if this is the case, please enforce it hard. View controller containment works well on it.
