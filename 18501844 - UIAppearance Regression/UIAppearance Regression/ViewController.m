//
//  ViewController.m
//  UIAppearance Regression
//
//  Created by Peter Steinberger on 30/09/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"
#import "PSPDFNavigationController.h"

@implementation ViewController

+ (void)initialize {
    // THIS WORKS ALL THE TIME
    // [self applyAppearance];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // WORKS on iOS 8.0 but not iOS 8.1.
    [self.class applyAppearance];
}

+ (void)applyAppearance {
    // PSPDFKit blue :)
    UIColor *brandColor = [UIColor colorWithRed:0.110f green:0.529f blue:0.757f alpha:1.f];
    UIColor *complementaryColor = UIColor.whiteColor;

    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:PSPDFNavigationController.class, nil];
    [navBar setBarTintColor:brandColor];
    [navBar setTintColor:complementaryColor];
}

@end
