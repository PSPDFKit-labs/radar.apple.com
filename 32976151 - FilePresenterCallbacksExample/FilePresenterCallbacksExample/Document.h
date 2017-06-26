//
//  Document.h
//  FilePresenterCallbacksExample
//
//  Created by Matej Bukovinski on 22/06/2017.
//  Copyright © 2017 PSPDFKit GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Document : NSObject <NSFilePresenter>

- (instancetype)initWithPresentedItemURL:(NSURL *)url string:(NSString *)string;

@property (readonly) NSURL *url;
@property (readonly) NSString *string;

@property (readonly) BOOL presentedItemDidChangeCalled;

- (void)writeWithCompletion:(void (^)(void))completion;

@end
