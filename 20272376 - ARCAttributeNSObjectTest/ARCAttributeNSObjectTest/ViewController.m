//
//  ViewController.m
//  ARCAttributeNSObjectTest
//
//  Created by Peter Steinberger on 24/03/15.
//  Copyright (c) 2015 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// Should be strong by default, but isn't.
@property (nonatomic) __attribute__((NSObject)) CGGradientRef maskGradientRef;
// Is strong by default.
@property (nonatomic) UIColor *color;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        UIColor *greyInner = [UIColor colorWithWhite:0.0 alpha:0.75];
        UIColor *greyOuter = [UIColor colorWithWhite:0.0 alpha:0.5];
        NSArray *gradientColors = @[(id)greyOuter.CGColor, (id)greyInner.CGColor];
        CGFloat gradientLocations[] = {0, 1};

        CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpace, (CFArrayRef)gradientColors, gradientLocations);
        self.maskGradientRef = gradientRef;
        CGGradientRelease(gradientRef);

        self.color = greyInner;
        CGColorSpaceRelease(colorSpace);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect bounds = self.view.bounds;
    CGPoint mid = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));

    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    CGContextDrawRadialGradient(UIGraphicsGetCurrentContext(),
                                self.maskGradientRef,
                                mid, 10,
                                mid, CGRectGetMidY(bounds),
                                kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:UIGraphicsGetImageFromCurrentImageContext()];
    imageView.frame = bounds;
    [self.view addSubview:imageView];
    UIGraphicsEndImageContext();
}

@end
