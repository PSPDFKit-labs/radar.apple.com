//
//  NavigationController.m
//  PreferredInterfaceOrientationForPresentationSample
//
//  Created by Matej Bukovinski and Peter Steinberger on 28. 11. 14.
//  Copyright (c) 2014 PSPDFKit. All rights reserved.
//

#import "NavigationController.h"

@implementation NavigationController

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

@end
