//
//  ViewController.m
//  PopoverControllerBackgroundColor
//
//  Created by Nishant Desai on 04/02/19.
//  Copyright © 2019 PSPDFKit. All rights reserved.
//

#import "ViewController.h"
#import "OverlayViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// Steps to Reproduce
// Open the app in split view of 50:50 and in portrait orientation with another app that supports landscape.
// Tap on the button "Show Popover"
// Rotate the iPad to landscape, or make the split to 75:25 for this App to force size class change.
// Popover is no longer visible.

- (IBAction)showPopover:(UIButton *)sender {
    UIViewController *overlayVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OverlayViewController"];
    overlayVC.modalPresentationStyle = UIModalPresentationPopover;

    UIPopoverPresentationController *popoverController = overlayVC.popoverPresentationController;
    popoverController.sourceRect = (CGRect) { self.view.center, sender.bounds.size };
    popoverController.sourceView = self.view;
    // We are setting the background color of the UIPopoverPresentationController object in
    // `-[OverlayViewController viewDidLayoutSubviews]` because we might be relying on some conditions that take place when the subviews are laid out.

    [self presentViewController:overlayVC animated:true completion:nil];
}

@end
