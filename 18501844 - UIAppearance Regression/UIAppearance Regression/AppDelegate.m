//
//  AppDelegate.m
//  UIAppearance Regression
//
//  Created by Peter Steinberger on 30/09/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "PSPDFNavigationController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ViewController *catalogController = [[ViewController alloc] initWithNibName:nil bundle:nil];

    UINavigationController *navigationController = [[PSPDFNavigationController alloc] initWithRootViewController:catalogController];
    self.window  = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}
@end
