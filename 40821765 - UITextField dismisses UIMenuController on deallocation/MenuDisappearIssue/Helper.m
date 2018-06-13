//
//  Helper.m
//  MenuDisappearIssue
//
//  Created by Peter Steinberger on 13.06.18.
//  Copyright © 2018 Peter Steinberger. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (void)destroyTextField:(UITextField *)textField {
    @try {
        // HACK: This works around a UIKit issue. https://github.com/PSPDFKit/PSPDFKit/issues/15522
        [textField valueForKeyPath:@"selectionView.invalidate"];
    }
    @catch (__unused NSException *exception) {} // Not critical
}

@end
