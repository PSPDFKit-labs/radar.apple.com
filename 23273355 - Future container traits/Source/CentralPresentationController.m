#import "CentralPresentationController.h"

@implementation CentralPresentationController

- (CGRect)frameOfPresentedViewInContainerView {
    static CGFloat const length = 300;
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

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];

    // This is never called if overrideTraitCollection is implemented such that the presented size class does not change.
    NSLog(@"%s %@", __PRETTY_FUNCTION__, newCollection);
}

// Set this to 0 to allow this class to know about trait collection changes.
#define OVERRIDE_TRAIT_COLLECTION 1
#if OVERRIDE_TRAIT_COLLECTION
- (UITraitCollection *)overrideTraitCollection {
    return [UITraitCollection traitCollectionWithTraitsFromCollections:@[
        [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact],
        [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassCompact],
    ]];
}
#endif

@end
