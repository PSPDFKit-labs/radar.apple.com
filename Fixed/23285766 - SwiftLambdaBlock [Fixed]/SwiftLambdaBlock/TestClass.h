//
//  TestClass.h
//  SwiftLambdaBlock
//
//  Created by Peter Steinberger on 27/10/15.
//  Copyright © 2015 PSPDFKit GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestClass : NSObject

- (instancetype)initWithURL:(NSURL *)URL passphraseProvider:(NSString *(^)(void))passphraseProvider salt:(NSString *)salt rounds:(NSUInteger)rounds;

@end
