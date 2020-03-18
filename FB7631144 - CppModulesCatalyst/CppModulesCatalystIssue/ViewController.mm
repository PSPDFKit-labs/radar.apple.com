//
//  ViewController.m
//  CppModulesCatalystIssue
//
//  Created by Peter Steinberger on 18.03.20.
//  Copyright © 2020 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

#import <UIKit/UIKit.h>

#import <vector>

@interface ViewController () {
    // Just a test to ensure file is compiled as C++
    std::vector<CGPoint> _points;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __auto_type view = [[UIView alloc] init];
    view.backgroundColor = UIColor.redColor;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:view];
    
    [NSLayoutConstraint activateConstraints:@[
        [view.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
    ]];
}


@end
