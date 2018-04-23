//
//  AppDelegate.m
//  ThreadLocalAndARC
//
//  Created by Peter Steinberger on 23.04.18.
//  Copyright © 2018 Peter Steinberger. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

static thread_local bool testSimpleVariable = false;

// Does not compile
static thread_local NSNumber *testARCVariable;

template <typename T>
class ObjCContainer {
public:
    ObjCContainer() : object([T new]) {}
    ObjCContainer(T *_Nonnull type) : object(type) {}
    T *_Nonnull object;
};
static thread_local ObjCContainer<NSNumber> testWrappedARCVariable = {@(42)};

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"Reading simple boolean: %@", @(testSimpleVariable));
    NSLog(@"Reading wrapped NSNumber: %@", testWrappedARCVariable.object);
    return YES;
}

@end
