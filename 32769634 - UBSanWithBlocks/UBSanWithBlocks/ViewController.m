//
//  ViewController.m
//  UBSanWithBlocks
//
//  Created by Peter Steinberger on 14/06/2017.
//  Copyright © 2017 Peter Steinberger. All rights reserved.
//

#import "ViewController.h"

#define PSPDF_NO_SANITIZE_INTEGER_OVERFLOW __attribute__((no_sanitize("integer")))

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self doEvil];
}

- (void)doEvil PSPDF_NO_SANITIZE_INTEGER_OVERFLOW {
    NSDictionary<NSString *, NSNumber*> *dict = @{@"Howdy": @(1), @"from Vienna": @(NSUIntegerMax), @"Definitely too much": @(1000)};

    // This works because of __attribute__((no_sanitize("integer")))
    NSUInteger pointsUsingOldSchoolEnumeration = 1;
    for (NSNumber *value in dict.allValues) {
        pointsUsingOldSchoolEnumeration += value.unsignedIntegerValue;
    }

    // This fails because __attribute__((no_sanitize("integer"))) doesn't work in the block
    // There's also no way to declare that for the block. Adding __attribute__((no_sanitize("integer"))) will not compile.
    __block NSUInteger pointsTotal = 1;
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull value, BOOL * _Nonnull stop) {
        pointsTotal += value.unsignedIntegerValue + 2;
    }];

    NSLog(@"Points are: %tu", pointsTotal);
}

@end
