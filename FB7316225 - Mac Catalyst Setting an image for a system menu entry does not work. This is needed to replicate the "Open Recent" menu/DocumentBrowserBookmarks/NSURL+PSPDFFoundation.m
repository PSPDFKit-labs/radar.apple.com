//
//  Copyright © 2017-2019 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import "NSURL+PSPDFFoundation.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSURL (PSPDFAdditions)

- (nullable NSData *)pspdf_bookmarkData {
    NSError *error;
    [self startAccessingSecurityScopedResource];
    NSData *bookmarkData = [self bookmarkDataWithOptions:NSURLBookmarkCreationSuitableForBookmarkFile includingResourceValuesForKeys:nil relativeToURL:nil error:&error];
    if (!bookmarkData) {
        NSLog(@"Unable to encode bookmark url: %@", error);
    }
    [self stopAccessingSecurityScopedResource];
    return bookmarkData;
}

+ (nullable NSURL *)pspdf_urlWithBookmarkData:(nullable NSData *)data {
    if (!data) {
        return nil;
    }
    NSError *error;
    NSURL *url = [NSURL URLByResolvingBookmarkData:(NSData *)data options:NSURLBookmarkResolutionWithoutUI relativeToURL:nil bookmarkDataIsStale:NULL error:&error];
    if (!url) {
        NSLog(@"Unable to decode bookmark: %@", error);
    }
    return url;
}

@end

NS_ASSUME_NONNULL_END
