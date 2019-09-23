//
//  Copyright © 2013-2019 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (PSPDFAdditions)

/**
 Invokes `bookmarkDataWithOptions:includingResourceValuesForKeys:relativeToURL:error:` with some
 default options and logs if the conversion fails.
 */
@property (nonatomic, readonly, nullable) NSData *pspdf_bookmarkData;

/// The inverse operation for pspdf_bookmarkData. Creates a new URL from the bookmark data.
+ (nullable NSURL *)pspdf_urlWithBookmarkData:(nullable NSData *)data;

@end

NS_ASSUME_NONNULL_END
