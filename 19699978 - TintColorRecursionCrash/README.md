## Crash when setting tintColor within tintColorDidChange

http://openradar.appspot.com/19699978

Summary:
Setting the tintColor property of an UIView within tintColorDidChange can lead to a crash if UIAppearance rules are set.

Steps to Reproduce:
Open attached example. Observe crash.

Expected Results:
Should not crash.

Actual Results:
Throws an exception -[__NSArrayM insertObject:atIndex:]: object cannot be nil somewhere inside/near TaggingAppearanceObjectSetterIMP called from tintColorDidChange.

Regression:
This crashes on iOS 7 as well.

Notes:
I did some digging in https://gist.github.com/steipete/ec17149d8bfd615718fc

Seems to only happen if we both change tintColor and have appearance rules defined
