//
//  PSPDFNavigationController.m
//  PSPDFKit
//
//  Copyright (c) 2013-2014 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import "PSPDFNavigationController.h"

@interface PSPDFNavigationController ()
@property (nonatomic, assign, getter = isCheckingParent) BOOL checkingParent;
@end

@implementation PSPDFNavigationController

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if ((self = [super initWithRootViewController:rootViewController])) {
        _rotationForwardingEnabled = YES;
        self.delegate = self;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController Rotation Handling

- (BOOL)shouldAutorotate {
    if (self.isRotationForwardingEnabled) {
        return self.topViewController.shouldAutorotate;
    }else {
        return super.shouldAutorotate;
    }
}

// Returns interface orientation masks.
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (!self.isRotationForwardingEnabled || self.isCheckingParent) {
        return [super supportedInterfaceOrientations];
    }else {
        self.checkingParent = YES;
        NSUInteger supportedInterfaceOrientations = self.topViewController.supportedInterfaceOrientations;
        self.checkingParent = NO;
        return supportedInterfaceOrientations;
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    // Need to keep track of state, else this could end in a recursion if the viewController asks his parent as well...
    if (!self.isRotationForwardingEnabled || self.isCheckingParent) {
        return [super preferredInterfaceOrientationForPresentation];
    }else {
        self.checkingParent = YES;
        UIInterfaceOrientation interfaceOrientation = self.topViewController.preferredInterfaceOrientationForPresentation;
        self.checkingParent = NO;
        return interfaceOrientation;
    }
}

@end
