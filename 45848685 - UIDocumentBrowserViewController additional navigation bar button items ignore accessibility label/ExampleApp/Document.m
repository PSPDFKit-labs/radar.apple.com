//
//  Document.m
//  ExampleApp
//
//  Created by Douglas Hill on 06/11/2018.
//  Copyright © 2018 Example. All rights reserved.
//

#import "Document.h"

@implementation Document
    
- (id)contentsForType:(NSString*)typeName error:(NSError **)errorPtr {
    // Encode your document with an instance of NSData or NSFileWrapper
    return [[NSData alloc] init];
}
    
- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError **)errorPtr {
    // Load your document from contents
    return YES;
}

@end
