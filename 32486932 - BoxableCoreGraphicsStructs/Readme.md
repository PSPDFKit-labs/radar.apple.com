Wrapping CGRect in ObjC via @(rect) should be possible. __attribute__((objc_boxable)) is missing
Originator:	steipete	Modify My Radar
Number:	rdar://32486932	Date Originated:	31-May-2017 05:52 PM
Status:	Open	Resolved:	
Product:	iOS + SDK	Product Version:	10.3.2
Classification:	Enhancement	Reproducible:	Always
 
Summary:
A while ago Objective-C got literals and a shorthand for boxing. This works for integers, enums and for any struct that declares the __attribute__((objc_boxable)) - this was all built and there are even tests in Clang that test this. However the declarations in CoreGraphics have never been updated.

Steps to Reproduce:
Try to compile this: (or see sample code)

    CGRect rect = (CGRect){};
    NSValue *boxed1 = @(rect);
    NSLog(@"Value: %@", boxed1);

Expected Results:
Should compile.

Actual Results:
error: illegal type 'CGRect' (aka 'struct CGRect') used in a boxed expression
    NSValue *boxed1 = @(rect);
                      ^~~~~~~
1 error generated.

Version:
10.3.2

Notes:
This would probably take less than an hour to add everywhere. Doesn’t break any legacy code, makes syntax nicer for everyone. Fully backwards compatible. A total win!

https://github.com/Microsoft/clang/blob/master/test/CodeGenObjC/Inputs/nsvalue-boxed-expressions-support.h

Turns out, this is simple to add:

typedef struct __attribute__((objc_boxable)) CGPoint CGPoint;
typedef struct __attribute__((objc_boxable)) CGSize CGSize;
typedef struct __attribute__((objc_boxable)) CGRect CGRect;
typedef struct __attribute__((objc_boxable)) CGVector CGVector;

Thanks https://gist.github.com/mayoff/08390f6d2f8a6d05b4a711cbeaf558a0 !