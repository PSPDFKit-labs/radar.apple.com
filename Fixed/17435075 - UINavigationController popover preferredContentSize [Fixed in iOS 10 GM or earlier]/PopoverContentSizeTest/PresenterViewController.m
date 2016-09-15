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
//	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:navigationController];
//	self.popover = popover;
//	[popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    navigationController.modalPresentationStyle = UIModalPresentationPopover;
    navigationController.popoverPresentationController.barButtonItem = sender;
    [self presentViewController:navigationController animated:YES completion:NULL];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"self presents: %@", self.presentedViewController);
    });
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
	self.popover = nil;
}

@end
