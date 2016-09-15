#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) UINavigationController *halfModal;
@end

@implementation ViewController

#pragma mark - Actions

- (IBAction)showUnRounded:(id)sender {
    [self removeHalfModal];
    [self showHalfModalAtOffsetFromBottom:490.66666666666669];
}

- (IBAction)showRounded:(id)sender {
    [self removeHalfModal];
    [self showHalfModalAtOffsetFromBottom:490.];
}

#pragma mark - Controller managment

- (void)showHalfModalAtOffsetFromBottom:(CGFloat)offset {
    UIViewController *controller = [UIViewController new];
    controller.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    UINavigationController *halfModal = [[UINavigationController alloc] initWithRootViewController:controller];
    self.halfModal = halfModal;

    [self addChildViewController:halfModal];
    [self.view addSubview:halfModal.view];
    [halfModal didMoveToParentViewController:self];

    [self updateHalfModalFrameForOffsetFromBottom:offset];
}

- (void)removeHalfModal {
    if (!self.halfModal) return;
    [self.halfModal willMoveToParentViewController:nil];
    [self.halfModal.view removeFromSuperview];
    [self.halfModal removeFromParentViewController];
    self.halfModal = nil;
}

#pragma mark - Layout

- (void)updateHalfModalFrameForOffsetFromBottom:(CGFloat)offsetFromBottom {
    CGRect availableBounds = self.view.bounds;
    CGRect halfModalRect = availableBounds;
    halfModalRect.origin.y = CGRectGetHeight(availableBounds) - offsetFromBottom;
    halfModalRect.size.height = offsetFromBottom;
    self.halfModal.view.frame = halfModalRect;
}

@end
