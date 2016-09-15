//
//  AppDelegate.m
//  PopoverCrash
//
//  Created by Peter Steinberger on 30/09/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ViewController *catalogController = [[ViewController alloc] initWithNibName:nil bundle:nil];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:catalogController];
    self.window  = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
