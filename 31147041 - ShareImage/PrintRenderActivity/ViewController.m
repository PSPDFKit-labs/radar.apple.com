//
//  ViewController.m
//  PrintRenderActivity
//
//  Created by Michael Ochs on 3/20/17.
//  Copyright © 2017 Bitecode. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
        self.navigationItem.rightBarButtonItem = share;
    }
    return self;
}

- (IBAction)share:(id)sender {
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[ [UIImage imageNamed:@"screenshot"] ] applicationActivities:nil];
    activity.popoverPresentationController.barButtonItem = sender;
    [self presentViewController:activity animated:YES completion:NULL];
}

@end
