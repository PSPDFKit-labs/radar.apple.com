//
//  Defines.h
//  ExtensibleStringEnums
//
//  Created by Michael Ochs on 8/23/16.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString *PSPDFRenderOption NS_EXTENSIBLE_STRING_ENUM;

FOUNDATION_EXPORT PSPDFRenderOption const PSPDFRenderOptionPreserveAspectRatioKey;
FOUNDATION_EXPORT PSPDFRenderOption const PSPDFRenderOptionIgnoreDisplaySettingsKey;

@interface Defines : NSObject

- (void)doSomething:(nullable NSDictionary<PSPDFRenderOption, id> *)something;

@end

NS_ASSUME_NONNULL_END
