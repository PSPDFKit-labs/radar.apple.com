#import "SecondViewController.h"

@implementation SecondViewController

- (void)loadView {
    UILabel *const label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithHue:0 saturation:0.1 brightness:1 alpha:1];
    label.text = @"Tap to present an activity view controller.";
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];

    self.view = label;
}

- (void)handleTap:(UIGestureRecognizer *)sender {
    UIActivityViewController *viewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"Hello"] applicationActivities:nil];

    // Don’t make assumptions about the size class we are in, as we crash if these are not set and the activity view controller appears as a popover.
    viewController.popoverPresentationController.sourceView = self.view;
    viewController.popoverPresentationController.sourceRect = (CGRect){.origin = [sender locationInView:self.view]};

    [self presentViewController:viewController animated:YES completion:nil];
}

@end
