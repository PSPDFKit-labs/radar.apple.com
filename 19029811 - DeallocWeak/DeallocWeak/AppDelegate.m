//
//  AppDelegate.m
//  DeallocWeak
//
//  Created by Peter Steinberger on 19/11/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "AppDelegate.h"

@interface CrashingClass : NSObject @end

@implementation CrashingClass

- (void)dealloc {
    // Referencing something weak during dealloc causes a trap in the runtime.
    // http://opensource.apple.com/source/objc4/objc4-646/runtime/objc-weak.mm
    __unused __weak id weakSelf = self;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    @autoreleasepool {
        [CrashingClass new];
    }

    return YES;
}

@end
