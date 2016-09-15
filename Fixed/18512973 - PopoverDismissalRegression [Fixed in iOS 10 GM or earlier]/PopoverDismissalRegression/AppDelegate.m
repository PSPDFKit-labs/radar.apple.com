//
//  AppDelegate.m
//  PopoverDismissalRegression
//
//  Created by Peter Steinberger on 01/10/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[ViewController alloc] init];
    self.window.makeKeyAndVisible;
    return YES;
}

@end
