//
//  ViewController.m
//  AlertControllerLayoutIssue
//
//  Created by Matej Bukovinski on 3. 03. 15.
//  Copyright (c) 2015 PSPDFKit. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (IBAction)brokenPressed:(UIButton *)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    controller.popoverPresentationController.sourceView = self.view;
    controller.popoverPresentationController.sourceRect = sender.frame;
    NSString *title = @"Whoopsie!";
    [controller addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *a) {
    }]];
    [self presentViewController:controller animated:YES completion:NULL];
}

- (IBAction)workingPressed:(UIButton *)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    controller.popoverPresentationController.sourceView = self.view;
    controller.popoverPresentationController.sourceRect = sender.frame;

    // Making sure the arrow points up or down fixes the issue.
    // Repositioning the button so the arrow automatically shows up or down helps as well, but is obviously
    // not always possible.
    controller.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown;

    NSString *title = @"Looking great!";
    [controller addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *a) {
    }]];
    [self presentViewController:controller animated:YES completion:NULL];
}

@end
