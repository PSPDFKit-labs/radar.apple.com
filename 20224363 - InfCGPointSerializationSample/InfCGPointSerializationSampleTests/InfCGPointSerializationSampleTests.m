//
//  InfCGPointSerializationSampleTests.m
//  InfCGPointSerializationSampleTests
//
//  Created by Matej Bukovinski on 19. 03. 15.
//  Copyright (c) 2015 PSPDFKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface TestPoint : NSObject <NSCoding>

@property (nonatomic) CGPoint point;
@property (nonatomic) CGFloat number;

@end

@implementation TestPoint

- (instancetype)init {
    if ((self = [super init])) {
        _point = CGPointMake(-1.f, -1.f);
        _number = -1.f;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if ((self = [self init])) {
        _point = [coder decodeCGPointForKey:@"point"];
        _number = [coder decodeDoubleForKey:@"number"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeCGPoint:self.point forKey:@"point"];
    [coder encodeDouble:self.number forKey:@"number"];
}

- (NSString *)description {
    NSString *superDescription = [super description];
    return [superDescription stringByAppendingFormat:@" - number: %f point: %@", self.number, NSStringFromCGPoint(self.point)];
}

@end

@interface InfCGPointSerializationSampleTests : XCTestCase @end

@implementation InfCGPointSerializationSampleTests

- (void)testInf {
    TestPoint *point = [[TestPoint alloc] init];
    point.number = INFINITY;
    point.point = CGPointMake(INFINITY, INFINITY);
    NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:point];
    TestPoint *newPoint = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
    XCTAssertEqual(newPoint.number, point.number);
    XCTAssert(CGPointEqualToPoint(point.point, newPoint.point), @"The original and de-serialized points do not match. Original: %@ De-searialized: %@", point, newPoint);
}

@end
