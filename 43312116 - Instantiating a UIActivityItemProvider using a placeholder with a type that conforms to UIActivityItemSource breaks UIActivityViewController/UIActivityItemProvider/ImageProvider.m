//
//  ImageProvider.m
//  UIActivityItemProvider
//
//  Created by Oscar Swanros on 8/14/18.
//  Copyright © 2018 Oscar Swanros. All rights reserved.
//

#import "ImageProvider.h"
#import "Image.h"

@implementation ImageProvider

+ (instancetype)provider {
    /*
     According to the documentation:

        placeholderItem
            An object that can stand in for the actual object you plan to create. The contents of the object may be empty but the class of the object must match the class of the object you plan to provide later.

     However, instantiating the item provider with an object conforming to UIActivityItemSource
     does not make the UIActivityViewController show the correct list of available actions
     that can be executed based on the item provider type here.
     */
    return [[ImageProvider alloc] initWithPlaceholderItem:[Image new]];

    /*
     The following does work.
     */
    return [[ImageProvider alloc] initWithPlaceholderItem:[UIImage new]];
}

- (id)item {
    return [UIImage imageNamed:@"doggo"];
}

@end
