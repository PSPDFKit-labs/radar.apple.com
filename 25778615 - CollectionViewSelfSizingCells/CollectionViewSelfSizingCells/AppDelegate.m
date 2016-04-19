//
//  AppDelegate.m
//  CollectionViewSelfSizingCells
//
//  Created by Michael Ochs on 4/18/16.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];

    window.rootViewController = [[ViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];

    self.window = window;
    [window makeKeyAndVisible];
    return YES;
}

@end
