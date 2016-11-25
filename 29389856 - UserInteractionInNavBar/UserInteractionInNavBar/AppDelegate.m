//
//  AppDelegate.m
//  UserInteractionInNavBar
//
//  Created by Michael Ochs on 11/25/16.
//  Copyright © 2016 PSPDFKit. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];

    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    window.rootViewController = navigationController;
    [window makeKeyAndVisible];
    self.window = window;

    return YES;
}

@end
