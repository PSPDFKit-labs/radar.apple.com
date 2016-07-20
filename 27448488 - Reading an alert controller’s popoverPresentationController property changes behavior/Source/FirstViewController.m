#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation FirstViewController

- (void)loadView {
    UILabel *const label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithHue:0.5 saturation:0.4 brightness:0.9 alpha:1];
    label.text = @"Tap to present a popover.";
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];

    self.view = label;
}

- (void)handleTap:(UIGestureRecognizer *)sender {
    UIViewController *const viewController = [[SecondViewController alloc] init];
    viewController.modalPresentationStyle = UIModalPresentationPopover;

    viewController.popoverPresentationController.sourceView = self.view;
    viewController.popoverPresentationController.sourceRect = (CGRect){.origin = [sender locationInView:self.view]};

    [self presentViewController:viewController animated:YES completion:nil];
}

@end
