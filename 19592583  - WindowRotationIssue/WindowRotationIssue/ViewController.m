//
//  ViewController.m
//  WindowRotationIssue
//
//  Created by Peter Steinberger on 25/01/15.
//  Copyright (c) 2015 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface PSPDFSupplementaryWindow : UIWindow
@property (nonatomic, strong) UIViewController *realRootViewController;
@end

@implementation PSPDFSupplementaryWindow


@end

@interface ViewController ()
@property (nonatomic, strong) UIWindow *window;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [[[UIAlertView alloc] initWithTitle:@"Radar Time" message:@"Adding a hidden window on iOS is a common way to add HUD overlay elements or other small features - iOS does this as well with it's text effects window. In iOS 8 however, a hidden window now affects rotation. As soon as we call addWindowForHUD the view rotates, which is should not. For some reason the rootViewController of the hidden view is consulted instead of the keyWindow's rootViewController. This is a regression from iOS 7." delegate:nil cancelButtonTitle:@"Oh well" otherButtonTitles:nil] show];

    [self addWindowForHUD];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.window = nil;
    });
}

- (void)addWindowForHUD {
    UIWindow *window = [[PSPDFSupplementaryWindow alloc] initWithFrame:CGRectZero];
    window.rootViewController = [UIViewController new];
    window.hidden = YES;
    self.window = window;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

@end
