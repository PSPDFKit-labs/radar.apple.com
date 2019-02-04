//
//  OverlayViewController.m
//  PopoverControllerBackgroundColor
//
//  Created by Nishant Desai on 04/02/19.
//  Copyright © 2019 PSPDFKit. All rights reserved.
//

#import "OverlayViewController.h"

@interface OverlayViewController ()

@end

@implementation OverlayViewController


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    // Changing the background color of its UIPopverPresentationController only when the layout is done.
    // Setting the color to a custom color breaks the popover whenever the size class is changed from Compact width to Regular Width.
    // The contents in the popover are not visible however the popover's background view is still visible.
    // The alpha of the view wrapping the popover's contents is 0.
    // This happens only when using a custom color and not when using a color object available directly as a property on UIColor.
    // Please comment/uncomment colors accordingly to see the results.

    // Popover Breaking Color - Custom Color
    self.popoverPresentationController.backgroundColor = self.view.backgroundColor;

    // Popover Breaking Color - Red Color
//    self.popoverPresentationController.backgroundColor = [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:1.f];

    // Working Color - Red Color
//    self.popoverPresentationController.backgroundColor = [UIColor redColor];
}

@end
