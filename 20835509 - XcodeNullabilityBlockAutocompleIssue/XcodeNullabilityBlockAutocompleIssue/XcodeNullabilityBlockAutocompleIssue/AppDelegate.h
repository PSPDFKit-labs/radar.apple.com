//
//  AppDelegate.h
//  XcodeNullabilityBlockAutocompleIssue
//
//  Created by Matej Bukovinski on 6. 05. 15.
//  Copyright (c) 2015 PSPDFKit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)myBlockMethod:(id (^)(NSObject *object))block;

@end

NS_ASSUME_NONNULL_END

