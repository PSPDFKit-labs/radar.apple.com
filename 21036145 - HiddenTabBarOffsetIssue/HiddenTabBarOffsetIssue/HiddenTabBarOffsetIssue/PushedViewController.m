//
//  PushedViewController.m
//  HiddenTabBarOffsetIssue
//
//  Created by Matej Bukovinski on 20. 05. 15.
//  Copyright (c) 2015 PSPDFKit. All rights reserved.
//

#import "PushedViewController.h"
#import "TableTableViewController.h"

#define ENABLE_WORKAROUND 0

@interface PushedViewController ()
@property (nonatomic) UINavigationController *halfModal;
@end

@implementation PushedViewController

#pragma mark - Actions

- (IBAction)presentChildPressed:(id)sender {
    [self removeHalfModal];
    [self showHalfModalAtOffsetFromBottom:300.f animated:YES];
}

#pragma mark - Controller managment

- (void)showHalfModalAtOffsetFromBottom:(CGFloat)offset animated:(BOOL)animated {
    [self removeHalfModal];
    [self addHalfModal];
    [self updateHalfModalFrameForOffsetFromBottom:0.f];
    if (animated) {
        [UIView animateWithDuration:0.3f animations:^{
            [self updateHalfModalFrameForOffsetFromBottom:offset];
        }];
    } else {
        [self updateHalfModalFrameForOffsetFromBottom:offset];
    }
}

- (void)addHalfModal {
#if ENABLE_WORKAROUND
    TableTableViewController *controller = [[TableTableViewController alloc] initWithStyle:UITableViewStylePlain];
    controller.hidesBottomBarWhenPushed = YES;
    UINavigationController *halfModal = [[UINavigationController alloc] init];
    halfModal.toolbarHidden = NO;
    [halfModal pushViewController:controller animated:NO];
#else
    TableTableViewController *controller = [[TableTableViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *halfModal = [[UINavigationController alloc] initWithRootViewController:controller];
#endif
    self.halfModal = halfModal;

    [self addChildViewController:halfModal];
    [self.view addSubview:halfModal.view];
    [halfModal didMoveToParentViewController:self];
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
