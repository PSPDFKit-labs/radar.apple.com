//
//  ViewController.m
//  AutomaticallyAdjustsContentInsetRegression
//
//  Created by Peter Steinberger on 20/11/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"
#import "ContainerViewController.h"

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    ContainerViewController *controller = [ContainerViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];

    navController.modalPresentationStyle = UIModalPresentationPopover;
    navController.popoverPresentationController.sourceView = self.view;
    navController.popoverPresentationController.sourceRect = CGRectMake(200.f, 200.f, 1.f, 1.f);
    [self presentViewController:navController animated:YES completion:^{

        // Show an alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Radar" message:@"Switch to the second view controller and notice that contentInset isn't set correctly." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:NULL]];
        [navController presentViewController:alert animated:YES completion:NULL];
    }];
}

@end
