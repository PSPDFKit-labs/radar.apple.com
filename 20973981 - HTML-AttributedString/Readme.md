Summary:
-[NSAttributedString initWithData:options:documentAttributes:error] is slow and can only be used on the main thread. This should work on any thread.

Steps to Reproduce:
See attached example project that shows the slowness and the possible crash

Expected Results:
1. Fast conversion of a HTML string to a NSAttributedString
2. Usable from every thread

Actual Results:
1. VERY slow
2. Can crash in a background thread (because WebKit)

Notes:
To be fair, I didn’t managed to build a sample that crashes, these crashers are random and are easier to happen in a larger application where more stuff is going on with different html pages being parsed at the same time.

Still is the case on iOS 9.3.2