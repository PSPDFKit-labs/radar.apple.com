//
//  AppDelegate.m
//  TableViewHeaders
//
//  Created by Oscar Swanros on 7/30/18.
//  Copyright © 2018 Oscar Swanros. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UILabel appearanceWhenContainedInInstancesOfClasses:@[UITableViewHeaderFooterView.self]].textColor = UIColor.redColor;

    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    self.window.rootViewController = [ViewController new];

    [self.window makeKeyAndVisible];

    return YES;
}

@end
