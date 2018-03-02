# Analyser warns about NSNumber assignment in condition

http://openradar.appspot.com/38059230

## Summary:
A common pattern in our Objective-C++ code is

```
if (auto const pointerThatWontBeNull = pointerThatMightBeNull) {
   // use pointerThatWontBeNull
}
```

This is effectively the same as the `if let` construct in Swift: it gives you a nonnull pointer from a nullable one if that pointer is not null. Note that pointerThatMightBeNull is often not a variable but some other expression.

However this results in an analyser warning with an NSNumber pointer:

```
if (auto const nonnullNSNumber = nullableNSNumber) {
   ...
}
```

The analyser wants us to explicitly check for nil to confirm we didn’t forget to call -boolValue. However we can’t do that in this construct.

## Steps to Reproduce:
Run the analyser in the attached sample project.

## Expected Results:
There should be no analyser warnings. It should be clear in this context that the code’s intent is to check for nil. There is no way we’d want to go into the conditional only if the result of calling -boolValue was true like this:

```
if (auto const value = [someNSNumber boolValue]) {
   ...
}
```

because value would always be YES, so is pointless.

## Actual Results:
There is an analyser warning:

main.mm:5:20: Converting a pointer value of type 'NSNumber *' to a primitive boolean value; instead, either compare the pointer to nil or call -boolValue

We have to have the assignment as its own statement, then check for nil separately, which is not so nice because the variable remains in scope:

```
auto const theNSNumber = somethingThatReturnsANullableNSNumber();
if (theNSNumber != nil) {
   // use theNSNumber
}
// theNSNumber is still in scope but please don’t use it.
```

## Version:
9.2 (9C40b)

## Notes:
This assignment in condition syntax is not possible in Objective-C without the ++.
