//
//  ViewController.m
//  PopoverCrash
//
//  Created by Peter Steinberger on 30/09/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIPopoverController *myPopoverController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Show Popover" style:UIBarButtonItemStylePlain target:self action:@selector(showPopoverPressed:)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // automate button pressing inside the second controller
    if (self.navigationController.viewControllers.count > 1) {
        [self performSelector:@selector(showPopoverPressed:) withObject:self.navigationItem.rightBarButtonItem afterDelay:0.3f];
        [self performSelector:@selector(popController) withObject:nil afterDelay:1.f];
    }else {
        // Lazy: Push one controller so we have a back button.
        [self.navigationController pushViewController:[ViewController new] animated:YES];
    }
}

- (void)popController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    if (self.myPopoverController) {
        //[self.myPopoverController.contentViewController.popoverPresentationController.presentedView performSelector:@selector(description) withObject:nil afterDelay:2.5f];
        [self.myPopoverController dismissPopoverAnimated:NO];
        self.myPopoverController = nil;
    }
}

- (void)showPopoverPressed:(UIBarButtonItem *)sender {
    UIViewController *contentVC = [UIViewController new];
    contentVC.view.backgroundColor = UIColor.redColor;
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:contentVC];
    self.myPopoverController = popover;
    popover.passthroughViews = @[self.navigationController.view];
    [popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
}

@end
