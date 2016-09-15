#import "DetailViewController.h"
#import "AncillaryViewController.h"

@implementation DetailViewController

- (NSString *)title {
    return @"Detail";
}

- (void)loadView {
    UILabel *const label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithHue:0.8 saturation:0.4 brightness:0.3 alpha:1];
    label.numberOfLines = 0;
    label.text = @"Tap to present ancillary view controller.";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.userInteractionEnabled = YES;

    self.view = label;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    // Use the presented view controller directly because self is deteched from its parent on popping so no longer finds the presented view controller.
    UIViewController *const presented = self.presentedViewController;

#if 1
    // When animated, the dismissal is deferred.
    [presented dismissViewControllerAnimated:YES completion:nil];
#elif 0
    // When disabling animation, it dismisses immediately but looks rough.
    [presented dismissViewControllerAnimated:NO completion:nil];
#else
    // Trying to do a view controller transition alongside a transition coordinator does not do anything.
    // But diving into views seems to work.
    UIView *const containerView = presented.presentationController.containerView;
    [self.transitionCoordinator animateAlongsideTransitionInView:containerView animation:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        containerView.alpha = 0;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        if (![context isCancelled]) {
            [presented dismissViewControllerAnimated:NO completion:nil];
        }
    }];
#endif
}

- (void)handleTap:(UIGestureRecognizer *)sender {
    if (self.presentedViewController) {
        return;
    }

    UIViewController *const ancillary = [[AncillaryViewController alloc] init];
    ancillary.modalPresentationStyle = UIModalPresentationPopover;
    ancillary.popoverPresentationController.sourceView = self.view;
    ancillary.popoverPresentationController.sourceRect = (CGRect){.origin = [sender locationInView:self.view]};
    ancillary.popoverPresentationController.passthroughViews = @[self.navigationController.view];

    [self presentViewController:ancillary animated:YES completion:nil];
}

@end
