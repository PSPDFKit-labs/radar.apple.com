//
//  AppDelegate.m
//  HTML-AttributedString
//
//  Created by Marco Sero on 15/05/2015.
//  Copyright (c) 2015 Marco Sero and Peter Steinberger. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"page" ofType:@"html"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    [self testConcurrencyWithData:data];
    [self testSlownessWithData:data];

    return YES;
}

- (void)testSlownessWithData:(NSData *)data {
    CFTimeInterval startTime = CACurrentMediaTime();
    NSInteger iterations = 1000;
    for (int i = 0; i < iterations; i++) {
        __unused NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:data
                                                                                options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                          NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                                     documentAttributes:nil error:nil];
    }
    
    CFTimeInterval endTime = CACurrentMediaTime();
    NSLog(@"Took %g s to generate %ld strings", endTime - startTime, iterations);
}

- (void)testConcurrencyWithData:(NSData *)data {
    NSLog(@"Now it will probably crash...");
    
    NSInteger iterations = 1000;
    for (int i = 0; i < iterations; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            __unused NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:data
                                                                                    options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                              NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                                         documentAttributes:nil error:nil];
        });
    }
    
    NSLog(@"It didn't crash, but it often happens");
}

@end
