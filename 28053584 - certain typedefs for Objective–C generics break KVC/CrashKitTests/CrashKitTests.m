//
//  CrashKitTests.m
//  CrashKitTests
//
//  Created by Daniel on 29.08.16.
//  Copyright © 2016 PSPDFKit. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface CrashKitTests : XCTestCase @end

/**
 Typedef for a JSON dictionary.

 Pros of this:
 - fights angle–bracket–blindness
 - conveys semantics beyond pure type information (essentially everybody has a decent concept of what JSON is)
 - can be used just like a regular class e.g. `[KVCBreakingJSON class]` works just fine
 - usage reads just like a regular class — e.g you have to include the `*` when declaring such a symbol

 Cons:
 - breaks KVC
 */
typedef NSDictionary<NSString *, id> KVCBreakingJSONDictionary;

/**
 Typedef for a JSON dictionary.

 Pros of this:
 - fights angle–bracket–blindness
 - conveys semantics beyond pure type information (essentially everybody has a decent concept of what JSON is)
 - works with KVC

 Cons:
 - can NOT be used just like a regular class e.g. `[KVCBreakingJSON class]` works just fine
 - usage DOES NOT read just like a regular class
 - it’s not completely unreasonable to expect `KVCCompatibleJSONDictionary stackThing = {};` to compile (which — thankfully — it doesn’t)
 */
typedef NSDictionary<NSString *, id> *KVCCompatibleJSONDictionary;

@interface KVCBreaker : NSObject

@property (copy) KVCBreakingJSONDictionary *iWillCrashKVCAtRunTime;
@property (copy) KVCCompatibleJSONDictionary whileIWillWorkFine;

@end

@implementation KVCBreaker @end

@implementation CrashKitTests

- (void)testBothPropertiesSupportKVC {
    KVCBreaker *const crashTestDummy = [KVCBreaker new];

    KVCBreakingJSONDictionary *someJSON = @{
        @"number": @1,
        @"bool": @NO,
        @"string": @"hello 🗺",
        @"null": [NSNull null],
        @"array": @[],
        @"object": @{},
    };
    // Set and get via regular access:
    XCTAssertNoThrow(crashTestDummy.iWillCrashKVCAtRunTime = someJSON, @"Regular setter should work");
    XCTAssertNoThrow(crashTestDummy.whileIWillWorkFine = someJSON, @"Regular setter should work");
    XCTAssertEqualObjects(crashTestDummy.iWillCrashKVCAtRunTime, someJSON, @"Regular getter should work");
    XCTAssertEqualObjects(crashTestDummy.whileIWillWorkFine, someJSON, @"Regular getter should work");

    // Set and get via KVC:
    NSString *const crashingProperty = NSStringFromSelector(@selector(iWillCrashKVCAtRunTime));
    XCTAssertNoThrow([crashTestDummy setValue:someJSON forKey:crashingProperty], @"KVC write to '%@' should work", crashingProperty);
    XCTAssertEqualObjects([crashTestDummy valueForKey:crashingProperty], someJSON, @"KVC read from '%@' should work", crashingProperty);

    NSString *const nonCrashingProperty = NSStringFromSelector(@selector(whileIWillWorkFine));
    XCTAssertNoThrow([crashTestDummy setValue:someJSON forKey:nonCrashingProperty], @"KVC write to '%@' should work", nonCrashingProperty);
    XCTAssertEqualObjects([crashTestDummy valueForKey:nonCrashingProperty], someJSON, @"KVC read from '%@' should work", nonCrashingProperty);
}

@end
