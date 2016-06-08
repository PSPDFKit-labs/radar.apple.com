//
//  ViewController.m
//  ViewControllerDismissalWarning
//
//  Created by Peter Steinberger on 20/11/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

static NSString *const PSPDFDidClickOnStuffNotification = @"PSPDFDidClickOnStuffNotification";

@interface PopoverContentController : UIViewController @end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // Being lazy here and not deregistering this for the radar
    [[NSNotificationCenter defaultCenter] addObserverForName:PSPDFDidClickOnStuffNotification object:nil queue:nil usingBlock:^(NSNotification *note) {

        // Show an alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Test" message:@"Will never be displayed" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:NULL]];

        // Using a dispatch_async on the main thread would fix the issue, but this is code smell!
        // Ideally this should never do nothing. Also bad: completion block is not called.
        // How could we even detect a failed presentation attempt?
        [self presentViewController:alert animated:YES completion:^{
            NSLog(@"Never called. Sad kitty is sad...");
        }];


        // The fun part is that UIAlertView of course doesn't care about view controller timing at all,
        // so this would also work without dispatching it.
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"Radar" message:@"Check the log to see the issue" delegate:nil cancelButtonTitle:@"Yes, Sir! I'll save the kittens!" otherButtonTitles:nil] show];
        });
    }];

    UIViewController *controller = [PopoverContentController new];
    controller.modalPresentationStyle = UIModalPresentationPopover;
    controller.popoverPresentationController.sourceView = self.view;
    controller.popoverPresentationController.sourceRect = CGRectMake(200.f, 200.f, 1.f, 1.f);
    [self presentViewController:controller animated:YES completion:NULL];
}

@end


@implementation PopoverContentController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Press me to see the issue" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(20.f, 20.f, 200.f, 200.f);
    [self.view addSubview:button];
}

- (void)buttonPressed:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:PSPDFDidClickOnStuffNotification object:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Did dismiss %@", self);
    }];
}

@end