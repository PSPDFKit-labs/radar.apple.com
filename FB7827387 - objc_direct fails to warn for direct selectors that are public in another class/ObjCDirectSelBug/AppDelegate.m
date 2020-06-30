//
//  AppDelegate.m
//  ObjCDirectSelBug
//
//  Created by Peter Steinberger on 30.06.20.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

PSPDF_OBJC_DIRECT_MEMBERS
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // This should fail, but succeeds as didReceiveMemoryWarning is declared on UIViewController
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didReceiveMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];

    // This should fail, but succeeds as didReceiveMemoryWarning is declared on our ViewController
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didReceiveMemoryWarningCustom) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];

    // Override point for customization after application launch.
    return YES;
}


- (void)didReceiveMemoryWarning {
    NSLog(@"Call me maybe?");
}

- (void)didReceiveMemoryWarningCustom {
    NSLog(@"Call me maybe?");
}



#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
