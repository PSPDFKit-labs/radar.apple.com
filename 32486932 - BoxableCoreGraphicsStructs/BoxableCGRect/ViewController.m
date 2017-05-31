//
//  ViewController.m
//  BoxableCGRect
//
//  Created by Peter Steinberger on 31/05/2017.
//  Copyright © 2017 Peter Steinberger. All rights reserved.
//

#import "ViewController.h"


#define BOXABLE __attribute__((objc_boxable))

typedef unsigned long NSUInteger;
typedef double CGFloat;

typedef struct BOXABLE _PSRange {
    NSUInteger location;
    NSUInteger length;
} PSRange;

typedef struct BOXABLE _PSPoint {
    CGFloat x;
    CGFloat y;
} PSPoint;

typedef struct BOXABLE _PSSize {
    CGFloat width;
    CGFloat height;
} PSSize;

typedef struct BOXABLE _PSRect {
    PSPoint origin;
    PSSize size;
} PSRect;


// Makes existing declarations compatible.
typedef struct __attribute__((objc_boxable)) CGPoint CGPoint;
typedef struct __attribute__((objc_boxable)) CGSize CGSize;
typedef struct __attribute__((objc_boxable)) CGRect CGRect;
typedef struct __attribute__((objc_boxable)) CGVector CGVector;



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];



     // UNCOMMENT TO SEE ERROR

    CGRect rect = (CGRect){};
    NSValue *boxed1 = @(rect);
    NSLog(@"Value: %@", boxed1);



    PSRect psRect = (PSRect){};
    NSValue *boxed2 = @(psRect);
    NSLog(@"Value: %@", boxed2);

    /**
     This feature was an external contribution: https://lowlevelbits.org/nsvalue-and-boxed-expressions/
     
     Looks like objc_boxable never made it into the struct declarations and it's not something we can add externally.

     */
}

@end
