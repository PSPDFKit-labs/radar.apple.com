//
//  XcodebuildHangsUITests.m
//  XcodebuildHangsUITests
//
//  Created by Julian Grosshauser on 18/07/16.
//  Copyright © 2016 PSPDFKit. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XcodebuildHangsUITests : XCTestCase @end

@implementation XcodebuildHangsUITests

- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)testExample {}

@end
