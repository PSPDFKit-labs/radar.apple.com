//
//  ViewController.m
//  ActionExtensionHost
//
//  Created by Michael Ochs on 1/23/17.
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)share:(UIButton *)sender {
    UIActivityViewController *activiy = [[UIActivityViewController alloc] initWithActivityItems:@[ @"Foobar" ] applicationActivities:nil];
    activiy.popoverPresentationController.sourceRect = sender.bounds;
    activiy.popoverPresentationController.sourceView = sender;
    [self presentViewController:activiy animated:YES completion:NULL];
}

@end
