//
//  Document.m
//  FilePresenterCallbacksExample
//
//  Created by Matej Bukovinski on 22/06/2017.
//  Copyright © 2017 PSPDFKit GmbH. All rights reserved.
//

#import "Document.h"

@interface Document () {
    NSOperationQueue *_presenterOperationQueue;
}

@property (readonly) dispatch_queue_t writeQueue;

@end

@implementation Document

- (instancetype)initWithPresentedItemURL:(NSURL *)url string:(NSString *)string {
    if ((self = [super init])) {
        _url = [url copy];
        _string = string;

        const __auto_type attributes = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, 0);
        _writeQueue = dispatch_queue_create(NULL, attributes);

        _presenterOperationQueue = [[NSOperationQueue alloc] init];
        _presenterOperationQueue.maxConcurrentOperationCount = 1;
        _presenterOperationQueue.name = @"com.pspdfkit.example.document.file-presenter";
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Coordinated operations

- (void)writeWithCompletion:(void (^)(void))completion {
    dispatch_async(self.writeQueue, ^{
        NSFileCoordinator *coordinator = [[NSFileCoordinator alloc] initWithFilePresenter:self];
        NSError *error;
        [coordinator coordinateWritingItemAtURL:self.url options:0 error:&error byAccessor:^(NSURL *newURL) {
            // Be slow on purpose!
            sleep(1);

            NSString *string = [@" " stringByAppendingString:self.string];

            NSError *writeError;
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingToURL:newURL error:&writeError];
            [fileHandle seekToEndOfFile];
            [fileHandle writeData:[string dataUsingEncoding:NSUTF8StringEncoding]];
            [fileHandle closeFile];

            NSAssert(writeError == nil, @"Write should not fail. Error: %@", writeError);
        }];
        NSAssert(error == nil, @"Coordination should not fail. Error: %@", error);
        completion();
    });
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSFilePresenter

- (NSURL *)presentedItemURL {
    return self.url;
}

- (NSOperationQueue *)presentedItemOperationQueue {
    return _presenterOperationQueue;
}

- (void)presentedItemDidChange {
    NSLog(@"Presented file did change notification: %@", self.presentedItemURL);
    _presentedItemDidChangeCalled = YES;
}

@end
