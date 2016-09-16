## Refencing an object weakly during dealloc leads to a runtime trap/crash.

http://openradar.appspot.com/19029811

Summary:
Referencing an object weakly during dealloc leads to a runtime trap/crash. 

Steps to Reproduce:
Run the provided, super small example, see it’s crashing.

Expected Results:
Weak should be the object or nil.

Actual Results:
Crash.

Regression:
Always crashed.

Notes:
From http://opensource.apple.com/source/objc4/objc4-646/runtime/objc-weak.mm i see that this was a conscious decision, but it’s still a source of hard-to-debug bugs and something that is quite unexpected. weak should in that case be either the object or nil, but not cause an abort.

Tested on iOS 10 GM, not fixed.
