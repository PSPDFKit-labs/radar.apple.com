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

- (instancetype)initWithURL:(NSURL *)URL passphraseProvider:(PSPDF_NOESCAPE NSString *(^)(void))passphraseProvider salt:(NSString *)salt rounds:(NSUInteger)rounds {
    if ((self = [super init])) {

        // TODO: should be illegal!
        dispatch_async(dispatch_get_main_queue(), ^{
            auto passphrase = passphraseProvider();
            NSLog(@"Passphrase is %@", passphrase);
        });

        // TODO: should be illegal as well.
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"Some time passed. Passphrase is still %@", passphraseProvider());
        });
    }
    return self;
}

@end
