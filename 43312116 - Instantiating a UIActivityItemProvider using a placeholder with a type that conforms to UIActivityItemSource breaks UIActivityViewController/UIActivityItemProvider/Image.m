//
//  Image.m
//  UIActivityItemProvider
//
//  Created by Oscar Swanros on 8/14/18.
//  Copyright © 2018 Oscar Swanros. All rights reserved.
//

#import "Image.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation Image

- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController {
    return [UIImage new];
}

- (nullable id)activityViewController:(nonnull UIActivityViewController *)activityViewController itemForActivityType:(nullable UIActivityType)activityType {
    return [UIImage imageNamed:@"doggo"];
}

- (UIImage *)activityViewController:(UIActivityViewController *)activityViewController thumbnailImageForActivityType:(UIActivityType)activityType suggestedSize:(CGSize)size {
    return [UIImage imageNamed:@"doggo"];
}

- (NSString *)activityViewController:(UIActivityViewController *)activityViewController subjectForActivityType:(UIActivityType)activityType {
    return @"Image";
}

- (NSString *)activityViewController:(UIActivityViewController *)activityViewController dataTypeIdentifierForActivityType:(UIActivityType)activityType {
    return (NSString *)kUTTypeImage;
}

@end
