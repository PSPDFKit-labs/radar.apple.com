//
//  AppDelegate.m
//  XcodeNullabilityBlockAutocompleIssue
//
//  Created by Matej Bukovinski on 6. 05. 15.
//  Copyright (c) 2015 PSPDFKit. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Try typing [self myBloc and accept the autocomplete suggestion:

    
    // You will get the follorwing result, which isn't valid objective C code
    // [self myBlockMethod:^id  __nonnull(NSObject * __nonnull) {}];

    // The correct autocompletion would be (the return nil; is needed for the compiler to be happy):
    // [self myBlockMethod:^id (NSObject *object) {return nil;}];

    return YES;
}

- (void)myBlockMethod:(id (^)(NSObject *object))block {

}

@end
