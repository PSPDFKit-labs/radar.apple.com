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

+ (void)callLambda:(NSString *(^)(void))passphraseProvider {
    passphraseProvider();
}

@end
