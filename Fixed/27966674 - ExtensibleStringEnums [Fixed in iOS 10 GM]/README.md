## Compiler errors out when setting a nullable dictionary with an extensible string enum to nil

http://openradar.appspot.com/27966674

Summary:
With Swift 3 we can now use `NS_EXTENSIBLE_STRING_ENUM` to make `NSString`s become an enum in Swift. When doing so for a list of keys that can be set in a dictionary and then making that dictionary parameter `nullable` Swift no longer compiles if you pass `nil` to that argument.

Steps to reproduce:
0. Open the attached Sample project and compile it
or:
in ObjC:
1. Create a typedef for NSString * that has NS_EXTENSIBLE_STRING_ENUM set
2. Create a couple of values for that type
3. Create a method that takes an argument nullable NSDictionary<YourExtensibleStringEnumType, id> *
in Swift:
4. Call the method you created in step 3 and pass nil as the value for the parameter, so that no dictionary is set.

Expected behavior:
This compiles fine as the argument is nullable

Actual behavior:
This errors out with the message: Undefined symbols for architecture x86_64: "protocol witness table for __C. YourExtensibleStringEnumType : Swift.Hashable in __ObjC", referenced from: ...

Notes:
This is fixed as soon as you call the same method with a non-nil value somewhere in the same scope. In this case, calling it with nil as well works just fine.
I filed this as well as SR-2460 in the Swift bug tracker

Fixed on Xcode 8 GM.
