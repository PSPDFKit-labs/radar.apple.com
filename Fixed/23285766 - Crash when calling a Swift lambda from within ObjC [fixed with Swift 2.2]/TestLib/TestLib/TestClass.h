//
//  TestClass.h
//  SwiftLambdaBlock
//
//  Created by Peter Steinberger on 27/10/15.
//  Copyright © 2015 PSPDFKit GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestClass : NSObject

// add __nullable to the NSString to fix the over-optimization.
+ (void)callLambda:(NSString *(^)(void))passphraseProvider;

@end

NS_ASSUME_NONNULL_END
