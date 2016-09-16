//
//  TestClass.h
//  SwiftLambdaBlock
//
//  Created by Peter Steinberger on 27/10/15.
//  Copyright © 2015 PSPDFKit GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define PSPDF_NOESCAPE __attribute__((noescape))

@interface TestClass : NSObject

- (instancetype)initWithURL:(NSURL *)URL passphraseProvider:(PSPDF_NOESCAPE NSString *(^)(void))passphraseProvider salt:(NSString *)salt rounds:(NSUInteger)rounds;

@end

NS_ASSUME_NONNULL_END
