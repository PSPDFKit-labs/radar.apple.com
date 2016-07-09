//
//  ViewController.m
//  PopoverContentControllerLeak
//
//  Created by Peter Steinberger on 06/12/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@interface PSPDFTestViewController : UIViewController
@end

@implementation PSPDFTestViewController

- (void)dealloc {
    NSLog(@"%@ deallocated!", self);
}

@end


@interface ViewController () <UIPopoverControllerDelegate>
@property (nonatomic, strong) UIPopoverController *popoverController;
@end

@implementation ViewController

@synthesize popoverController = popoverController_;

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    //////////////////////////////////////////////////////
    // Experiment 1: Observe that this view controller never gets deallocated
    @autoreleasepool {
        UIViewController *controller = [PSPDFTestViewController new];
        controller.modalPresentationStyle = UIModalPresentationPopover;
        [controller popoverPresentationController];
    }

    //////////////////////////////////////////////////////
    // Experiment 2: My real-world issue with this:

    UIViewController *controller = [PSPDFTestViewController new];
    controller.view.backgroundColor = [UIColor redColor];

    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:controller];
    popoverController.delegate = self;
    [popoverController presentPopoverFromRect:CGRectMake(200.f, 200.f, 1.f, 1.f) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.popoverController = popoverController;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // Show an alert to explain the radar
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Radar" message:@"Merely accessing popoverPresentationController is enough to create a retain cycle." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:NULL]];
        [controller presentViewController:alert animated:YES completion:NULL];
    });
}

// This is really really strange. Simply implementing this and returning YES is enough to "fix" the issue.
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {

    // UIKit is creating a retain cycle here.
    // UIPopoverPresentationController is strongly saved in the content view controller.
    // Then the UIPopoverPresentationController strongly references the view controller.
    [popoverController.contentViewController popoverPresentationController];
    self.popoverController = nil;
}

@end
