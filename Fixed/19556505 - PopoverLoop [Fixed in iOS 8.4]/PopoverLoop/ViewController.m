//
//  ViewController.m
//  PopoverLoop
//
//  Created by Peter Steinberger on 22/01/15.
//  Copyright (c) 2015 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewController.h"

@interface ViewController ()
//@property (nonatomic, strong) UIPopoverController *popover;
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // Show the red popover
    UIViewController *controller = [TestTableViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    navController.preferredContentSize = CGSizeMake(320, 100);
    CGRect sourceRect = UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? CGRectMake(900, 760, 1.f, 1.f) : CGRectMake(760, 900, 1.f, 1.f);

    // Use this to test iOS 7 instead.
//        self.popover = [[UIPopoverController alloc] initWithContentViewController:navController];
//        [self.popover presentPopoverFromRect:targetRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];

    navController.modalPresentationStyle = UIModalPresentationPopover;
    navController.popoverPresentationController.sourceView = self.view;
    navController.popoverPresentationController.sourceRect = sourceRect;

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Radar" message:@"Watch the popover move, then get into a state where UIKit loops endlessly, freezing the application." preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Okay, let's freeze!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self presentViewController:navController animated:YES completion:NULL];
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

@end
