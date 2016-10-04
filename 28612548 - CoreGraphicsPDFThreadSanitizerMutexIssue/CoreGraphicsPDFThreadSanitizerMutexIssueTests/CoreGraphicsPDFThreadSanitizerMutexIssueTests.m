//
//  CoreGraphicsPDFThreadSanitizerMutexIssueTests.m
//  CoreGraphicsPDFThreadSanitizerMutexIssueTests
//
//  Created by Peter Steinberger on 04/10/2016.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface CoreGraphicsPDFThreadSanitizerMutexIssueTests : XCTestCase
@end

@implementation CoreGraphicsPDFThreadSanitizerMutexIssueTests

- (void)testCreatePDFWithMutexIssueWhenThreadSanitizerIsEnabled {
    NSMutableData *pdfData = [NSMutableData data];
    CGRect rect = CGRectMake(0, 0, 400.f, 400.f);
    UIGraphicsBeginPDFContextToData(pdfData, rect, @{});
    UIGraphicsBeginPDFPageWithInfo(rect, nil);
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Shape shadow
    UIColor *shadowColor = [UIColor.blackColor colorWithAlphaComponent:0.25f];
    CGContextSetShadowWithColor(context, CGSizeMake(0.0f, -2.0f), 4.0f, shadowColor.CGColor);

    [UIColor.whiteColor set];
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)] fill];
    UIGraphicsEndPDFContext();

}

@end
