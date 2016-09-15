//
//  ViewController.m
//  PopoverDismissalRegression
//
//  Created by Peter Steinberger on 01/10/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    ModalViewController *modal = [[ModalViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:modal];
    [self presentViewController:navController animated:YES completion:NULL];
}

@end
