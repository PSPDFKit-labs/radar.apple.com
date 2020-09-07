//
//  CustomPresentationController.m
//  PresentationControllerTraitCollections
//
//  Created by Nishant Desai on 07/09/20.
//

#import "CustomPresentationController.h"

@implementation CustomPresentationController

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];

    /**
     The `UITraitCollection` object (`newCollection`) received on backgrounding the app contains
     incorrect horizontal size class (`newCollection.horizontalSizeClass`) on the iOS 14 beta.
     The size class received is `UIUserInterfaceSizeClassCompact` at all times even when the app is running in full screen width
     and height.
     On iOS 13 and earlier the trait collections received are as expected which is `Regular` for
     `horizontalSizeClass` when the app is running in full screen.
     */
    NSLog(@"%s %@", __PRETTY_FUNCTION__, newCollection);
}

@end
