//
//  ModalViewController.m
//  PopoverDismissalRegression
//
//  Created by Peter Steinberger on 01/10/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController () <UIPopoverControllerDelegate>
@property (nonatomic, strong) UIPopoverController *myPopoverController;
@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    UIViewController *popoverViewController = [UIViewController new];
    popoverViewController.view.backgroundColor = UIColor.yellowColor;
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:popoverViewController];
    [popover presentPopoverFromRect:CGRectMake(100.f, 100.f, 1.f, 1.f) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    popover.delegate = self;
    self.myPopoverController = popover;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(400, 400, 500, 500)];
    label.text = @"Tap to dismiss the popover!\n See that we also dismiss the modal parent\nregression from iOS 7 to 8.";
    label.numberOfLines = 0;
    [label sizeToFit];
    [self.view addSubview:label];
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {

    // Complex application logic might do tests and in the end independeltly dismisses the popover
    // I know this is wrong and looks stupid here, but it's still a regression in UIKit.
    // (People will always find ways to kill your API. I see that in PSPDFKit every day :)
    [self.myPopoverController dismissPopoverAnimated:NO];

    return YES;
}

@end
