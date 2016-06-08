//
//  AppDelegate.m
//  NonStatusBarAffectingWindow
//
//  Created by Peter Steinberger on 27/11/15.
//  Copyright © 2015 PSPDFKit GmbH. All rights reserved.
//

#import "AppDelegate.h"

@interface WindowViewController : UIViewController @end
@implementation WindowViewController

- (BOOL)prefersStatusBarHidden {
    return NO;
}

@end

@interface CustomWindow : UIWindow @end
@implementation CustomWindow

// Uncomment that to get the correct behavior.
//- (BOOL)_canAffectStatusBarAppearance { return NO; }

@end

@interface AppDelegate ()
@property (nonatomic) UIWindow *overlayWindow;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    UIViewController *rootVC = [[UIViewController alloc] init];
    rootVC.view.backgroundColor = UIColor.whiteColor;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootVC];
    navController.navigationBar.barStyle = UIBarStyleBlack;
    self.window.rootViewController = navController;
    self.window.hidden = NO;

    UIViewController *windowVC = [[WindowViewController alloc] init];
    windowVC.view.backgroundColor = UIColor.redColor;

    self.overlayWindow = [[CustomWindow alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.overlayWindow.windowLevel = UIWindowLevelStatusBar;
    // We *need* to do that.
    // Otherwise 'NSInternalInconsistencyException', reason: 'Application windows are expected to have a root view controller at the end of application launch'
    self.overlayWindow.rootViewController = windowVC;

    [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(toggleWindow) userInfo:nil repeats:YES];

    return YES;
}

- (void)toggleWindow {
    self.overlayWindow.hidden = !self.overlayWindow.isHidden;
}

@end
