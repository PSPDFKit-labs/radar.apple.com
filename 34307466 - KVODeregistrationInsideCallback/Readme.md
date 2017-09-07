Summary:
Removing a KVO observer while it calls out in NSKeyValueObservingOptionInitial throws an 'NSRangeException', reason: 'Cannot remove an observer (…) because it is not registered as an observer.' 

However it is registered - it is just still in the registration phase and doing the initial callback because of NSKeyValueObservingOptionInitial. This of course is a stupid example, but complex real-world code might has conditions where something is observed and immediately finishes. We discovered multiple crashes in PDF Viewer because of that.

Steps to Reproduce:
Open Sample.
Observe exception throw.

Expected Results:
unobserving while in the initial callback should still work. This is leaking out an implementation detail and this issue is not documented, thus I consider it a bug.

Actual Results:
Unobserve crashes. 

Version:
iOS 11b10

Notes:
Tested on iOS 8+ and always fails.