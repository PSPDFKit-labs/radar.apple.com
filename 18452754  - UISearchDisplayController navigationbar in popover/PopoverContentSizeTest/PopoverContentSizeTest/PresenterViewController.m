//
//  PresenterViewController.m
//  PopoverContentSizeTest
//
//  Created by Matej Bukovinski on 24. 06. 14.
//  Copyright 2014 PSPDFKit. All rights reserved.
//

#import "PresenterViewController.h"

@interface PresenterViewController () <UIPopoverControllerDelegate>

@property (nonatomic, strong) UIPopoverController *popover;

@end

@implementation PresenterViewController

- (IBAction)showPopoverPressed:(UIBarButtonItem *)sender {
	if (self.popover) {
		[self.popover dismissPopoverAnimated:YES];
		self.popover = nil;
		return;
	}
	
	UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverNavigationController"];
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:navigationController];
	self.popover = popover;
	[popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
	self.popover = nil;
}

@end
