//
//  ContainerViewController.m
//  AutomaticallyAdjustsContentInsetRegression
//
//  Created by Peter Steinberger on 21/11/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "ContainerViewController.h"
#import "CollectionViewController.h"

@interface ContainerViewController ()
@property (nonatomic, copy) NSArray *visibleControllers;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) UISegmentedControl *filterSegment;
@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CollectionViewController *collection1 = [[CollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    CollectionViewController *collection2 = [[CollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    self.visibleControllers = @[collection1, collection2];

    [self updateSelectionSegment];
    [self showControllerAtIndex:0 animated:NO];
}

- (void)showControllerAtIndex:(NSUInteger)index animated:(BOOL)animated {
    UIViewController *newController = self.visibleControllers[index];
    UIViewController *currentController = self.currentViewController;

    if (newController != currentController) {
        self.currentViewController = newController;

        [self addChildViewController:newController];
        [currentController willMoveToParentViewController:nil];
        [self.view addSubview:newController.view];
        [newController didMoveToParentViewController:self];

        newController.automaticallyAdjustsScrollViewInsets = YES;

        // Update popover size if we're loading the first time.
        [UIView performWithoutAnimation:^{
            // Ensure our layout is created before we set the size - less implicit animations.
            [self.view layoutIfNeeded];

            // Update content inset and set new frame
            newController.view.frame = self.view.bounds;
            newController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        }];

        [UIView transitionFromView:currentController.view
                            toView:newController.view
                          duration:animated ? 0.1f : 0.f
                           options:animated ? UIViewAnimationOptionTransitionCrossDissolve : UIViewAnimationOptionTransitionNone
                        completion:^(BOOL finished) {
                            if (finished) {
                                [currentController.view removeFromSuperview];
                                [currentController removeFromParentViewController];
                            }
                        }];

        // This ensures that the automaticallyAdjustsScrollViewInsets magic works
        // On our newly added view controller as well.
        // This triggers _layoutViewController which then triggers
        // _computeAndApplyScrollContentInsetDeltaForViewController:
        // which finally updates our content inset of the scroll view (if any)
        //[self.navigationController.view setNeedsLayout];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Selection Updating

- (void)updateSelectionSegment {
    if (self.visibleControllers.count > 1) {
        UISegmentedControl *filterSegment = [[UISegmentedControl alloc] initWithItems:@[@"Controller 1", @"Controller 2"]];
        filterSegment.selectedSegmentIndex = 0;
        filterSegment.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [filterSegment addTarget:self action:@selector(filterSegmentChanged:) forControlEvents:UIControlEventValueChanged];
        self.filterSegment = filterSegment;
        self.navigationItem.titleView = self.filterSegment;
    } else {
        self.navigationItem.titleView = nil;
    }
}

- (void)filterSegmentChanged:(UISegmentedControl *)segment {
    [self showControllerAtIndex:segment.selectedSegmentIndex animated:YES];
}

@end
