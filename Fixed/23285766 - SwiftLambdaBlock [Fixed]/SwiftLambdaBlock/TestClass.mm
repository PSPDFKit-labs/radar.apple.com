//
//  TestClass.mm
//  SwiftLambdaBlock
//
//  Created by Peter Steinberger on 27/10/15.
//  Copyright © 2015 PSPDFKit GmbH. All rights reserved.
//

#import "TestClass.h"
#include <vector>

@implementation TestClass

- (instancetype)initWithURL:(NSURL *)URL passphraseProvider:(NSString *(^)(void))passphraseProvider salt:(NSString *)salt rounds:(NSUInteger)rounds {

    NSParameterAssert(passphraseProvider);
    auto passphrase = passphraseProvider();
    NSParameterAssert(passphrase);

    if ((self = [super init])) {
        new std::vector<int>();
    }
    return self;
}

@end
