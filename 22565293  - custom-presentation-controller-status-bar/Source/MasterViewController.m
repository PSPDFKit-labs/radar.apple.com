#import "MasterViewController.h"

#import "CentralPresentationController.h"
#import "DetailViewController.h"

@interface MasterViewController () <UIViewControllerTransitioningDelegate>

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
    label.text = @"Tap to present another view controller.";
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
    UIViewController *const detail = [[DetailViewController alloc] init];
    detail.modalPresentationStyle = UIModalPresentationCustom;
    detail.transitioningDelegate = self;

    [self presentViewController:detail animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[CentralPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
