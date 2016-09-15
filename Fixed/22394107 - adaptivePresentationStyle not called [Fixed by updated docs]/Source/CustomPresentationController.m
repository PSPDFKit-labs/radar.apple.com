#import "CustomPresentationController.h"

@implementation CustomPresentationController

- (UIModalPresentationStyle)adaptivePresentationStyle {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return UIModalPresentationFullScreen;
}

- (CGRect)frameOfPresentedViewInContainerView {
    return CGRectMake(40, 40, 200, 200);
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.presentedView setFrame:self.frameOfPresentedViewInContainerView];
    } completion:NULL];
}

@end
