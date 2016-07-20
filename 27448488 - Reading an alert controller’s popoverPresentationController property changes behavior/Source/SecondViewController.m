#import "SecondViewController.h"

@implementation SecondViewController

- (void)loadView {
    UILabel *const label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithHue:0 saturation:0.1 brightness:1 alpha:1];
    label.text = @"Tap to present an action sheet.";
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];

    self.view = label;
}

- (void)handleTap:(UIGestureRecognizer *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Do the thing" style:UIAlertActionStyleDefault handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Do the other thing" style:UIAlertActionStyleDefault handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];

#define SHOW_AS_SHEET 1

#if SHOW_AS_SHEET
    // Don’t even read popoverPresentationController.
    // This means UIKit will raise an exception if we are in, or go into, a horizontally regular environment.
#else
    // Show as popover
    alertController.popoverPresentationController.sourceView = self.view;
    alertController.popoverPresentationController.sourceRect = (CGRect){.origin = [sender locationInView:self.view]};
#endif

    [self presentViewController:alertController animated:YES completion:nil];
}

@end
