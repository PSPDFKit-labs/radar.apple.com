#import "CentralPresentationController.h"

@implementation CentralPresentationController

- (CGRect)frameOfPresentedViewInContainerView {
    static CGFloat const length = 280;
    return (CGRect) {
        .origin.x = 0.5 * (CGRectGetWidth(self.containerView.bounds) - length),
        .origin.y = 0.5 * (CGRectGetHeight(self.containerView.bounds) - length),
        .size.width = length,
        .size.height = length,
    };
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.presentedView.frame = self.frameOfPresentedViewInContainerView;
    } completion:NULL];
}

#define FIX_USING_PRIVATE_API 0

#if FIX_USING_PRIVATE_API
- (BOOL)_shouldChangeStatusBarViewController {
    return NO;
}
#endif

@end
