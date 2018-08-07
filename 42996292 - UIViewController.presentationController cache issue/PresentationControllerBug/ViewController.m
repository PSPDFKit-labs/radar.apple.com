//
//  ViewController.m
//  PresentationControllerBug
//
//  Created by Aditya on 07/08/18.
//  Copyright © 2018 caughtinflux. All rights reserved.
//

#import "ViewController.h"

@interface CustomPresentationController : UIPresentationController
@end

@implementation CustomPresentationController
@end

@interface ViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *viewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    
    // First, access the default presentation controller.
    // This should be the _UIFullscreenPresentationController, by default.
    NSLog(@"Presentation Controller: %@", viewController.presentationController);
    
    // Set the transitioning delegate to vend the custom controller, and set presentation style to custom.
    viewController.transitioningDelegate = self;
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    
    // Here, we'd expect the presentation controller to be the `CustomPresentationController`.
    // However, the delegate method is never called, and the presentation controller returned is the same one logged on line 30.
    // If line 30 is commented out, this works as expected.
    NSLog(@"Presentation controller now: %@", viewController.presentationController);
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[CustomPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
