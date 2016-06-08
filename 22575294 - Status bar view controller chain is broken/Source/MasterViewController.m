#import "MasterViewController.h"

#import "LittleViewController.h"

@interface MasterViewController () <UIPopoverPresentationControllerDelegate>

@end

@implementation MasterViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)loadView {
    UILabel *const label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithHue:0.5 saturation:0.4 brightness:0.3 alpha:1];
    label.numberOfLines = 0;
    label.text = @"Tap to show a popover.";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.userInteractionEnabled = YES;

    self.view = label;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
}

- (void)handleTap:(UIGestureRecognizer *)sender {
    LittleViewController *const little = [[LittleViewController alloc] init];
    little.modalPresentationStyle = UIModalPresentationPopover;
    little.popoverPresentationController.delegate = self;
    little.popoverPresentationController.sourceView = self.view;
    little.popoverPresentationController.sourceRect = (CGRect){.origin = [sender locationInView:self.view]};

    [self presentViewController:little animated:YES completion:nil];
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
    return UIModalPresentationNone;
}

@end
