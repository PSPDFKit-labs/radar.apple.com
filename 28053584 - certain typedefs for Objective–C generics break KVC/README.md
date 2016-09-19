## Xcode/Clang: certain typedefs for Objective–C generics break KVC

http://openradar.appspot.com/28053584

Summary:
When using a typedef for a special configuration of a generic container such as NSDictionary, there are two variants to write the typedef:
One that hides the pointer nature — `typedef ExistingClass<Qualifiers> *Alias` —  and one that requires you to remain explicit about it — `typedef ExistingClass<Qualifiers> Alias`.

The second form allows you to use `Alias` just as if it was a regular Objective–C class (e.g. you’d still include the asterisk when you declare a variable, and writing`[foo isKindOfClass:[TYPEDEFD_THING class]];` compiles just fine).
Unfortunately, if you choose this form, and declare a property of this type, this property is not KVC compliant, although it really should be.

Steps to Reproduce:
Run the unit tests of the attached sample project.


Expected Results:
The test passes.


Actual Results:
The test fails because `valueForUndefinedKey:`/`setValue:forUndefinedKey:` get called when attempting to do KVC against the property that uses the typedef form which doesn’t mask the pointer nature.

Tested on Xcode 8 GM, not fixed.
