//
//  ModalController.m
//  PreferredInterfaceOrientationForPresentationSample
//
//  Created by Matej Bukovinski and Peter Steinberger on 28. 11. 14.
//  Copyright (c) 2014 PSPDFKit. All rights reserved.
//

#import "ModalController.h"

@implementation ModalController

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    NSLog(@"preferredInterfaceOrientationForPresentation called!");
    return UIInterfaceOrientationLandscapeLeft;
}

- (IBAction)closePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
