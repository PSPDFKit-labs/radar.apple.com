//
//  ViewController.m
//  UIActivityViewControllerRegression
//
//  Created by Peter Steinberger on 09/07/16.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // just being lazy
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[@"Hello World"] applicationActivities:nil];

        // This looks trivial, but we added an explicit everywhere before accessing popoverPresentationController because of rdar://19167124
        // (Accessing popoverPresentationController creates a retain cycle. Still open as of iOS 10b2)
        //
        // Checking this works on iOS 8/9 but fails on iOS 10, because modalPresentationStyle returns the value 100 instead of 7.
        // This is a breaking, backwards incompatible change - should at least be protected by an UIApplicationLinkedOnVersion check
        // to not crash apps that have been built with SDK 9.
        if (activityVC.modalPresentationStyle == UIModalPresentationPopover) {
            activityVC.popoverPresentationController.sourceView = self.view;
            activityVC.popoverPresentationController.sourceRect = CGRectMake(30.f, 30.f, 1.f, 1.f);
        }
        [self presentViewController:activityVC animated:YES completion:NULL];
    });
}

@end
