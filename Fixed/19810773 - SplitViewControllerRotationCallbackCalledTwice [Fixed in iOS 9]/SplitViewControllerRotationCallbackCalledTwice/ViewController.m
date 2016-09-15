//
//  ViewController.m
//  SplitViewControllerRotationCallbackCalledTwice
//
//  Created by Peter Steinberger on 12/02/15.
//  Copyright (c) 2015 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@interface ContentViewController : UIViewController
@end

@implementation ContentViewController

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

    NSLog(@"Called %s", __PRETTY_FUNCTION__);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];

    NSLog(@"Called %s", __PRETTY_FUNCTION__);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];

    NSLog(@"Called %s", __PRETTY_FUNCTION__);
}

@end

@interface ViewController ()
@property (nonatomic, strong) UISplitViewController *splitViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[[UIAlertView alloc] initWithTitle:@"Radar" message:@"Observe that all rotation callbacks in the content view controller are called twice; once from the UISplitViewController and a second time from the UIPresentationController. This is a regression from iOS 7; where they were simply called from UISplitViewController." delegate:nil cancelButtonTitle:@"Can't wait to fix this!" otherButtonTitles:nil] show];

    // Initialize split view controller
    UISplitViewController *splitViewController = [UISplitViewController new];

    UIViewController *viewController = [UIViewController new];
    viewController.view.backgroundColor = UIColor.whiteColor;
    UIViewController *contentViewController = [ContentViewController new];
    contentViewController.view.backgroundColor = UIColor.redColor;
    splitViewController.viewControllers = @[viewController, contentViewController];

    [self addChildViewController:splitViewController];
    [self.view addSubview:splitViewController.view];
    [splitViewController didMoveToParentViewController:self];
    self.splitViewController = splitViewController;
}

@end
