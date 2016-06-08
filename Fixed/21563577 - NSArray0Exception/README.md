Summary:
Instance methods added to NSArray via categories that return `instancetype` will crash when called on the `__NSArray0` shared instance, which seems to represent all empty immutable arrays. This is typical for ‘map’-style methods that convert one array to another array of the same type.

Specifically, in order to return an object of `instancetype`, a ‘map’ method method might end like this:

	return [[[self class] alloc] initWithArray:mappedArray];

If the class is `__NSArray0`, this code tries to create a new instance of `__NSArray0`, which does not implement `initWithObjects:count:`. Not implementing this method is reasonable; I don’t think it should get as far as that point.

My proposed solution is something along the lines of `__NSArray0` overriding `allocWithZone:` and returning the immutable array placeholder, so the placeholder can work out what sort of object needs to be created (either an `__NSArrayI` or `__NSArray0`).

Note that this is not a problem with `__NSArrayI` and `__NSArrayM` because instances of these classes can be created with the normal `alloc`/`init` pattern.

Steps to Reproduce:
Run the attached sample project on OS X 10.11 or copy into an iOS project and run on iOS 9.

Expected Results:
Inside a method where `self` is the `__NSArray0` instance, `[[[self class] alloc] initWith...` should return a suitable array instance.

Actual Results:
An exception is raised:

*** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[NSArray initWithObjects:count:]: method only defined for abstract class.  Define -[__NSArray0 initWithObjects:count:]!'

Version:
Version 7.0 beta (7A121l)

Notes:
Regression:

The code works as expected on earlier versions of iOS and OS X. It looks like empty arrays used to be a shared instance of `__NSArrayI`.
Originally filed as 21563577 by one from my team.

Workaround:
Changing map methods to return instances of `NSArray` is often fine, but might be undesirable if custom subclasses of `NSArray` were in use.

Bug category:
I didn’t know whether to file this under iOS SDK or OS X SDK since it is in Foundation.

Configuration:
This problem is new in iOS 9 and OS X 10.11.



Update: Fixed in 10.11.4 or earlier.