//
//  ViewController.m
//  MenuRotationClippingIssue
//
//  Created by Peter Steinberger on 28/01/15.
//  Copyright (c) 2015 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[[UIAlertView alloc] initWithTitle:@"Radar. Test with iPhone 5/5s/6!" message:@"Rotate, then press the button to show the menu. Notice that the menu will be presented clipped in landscape mode. The UITextEffectsWindow created by the menu has the wrong coordinates. This only happens if the LaunchImage is missing, so currently this is an issue for iPhone 5/5s/6/6+. It does work flawlessly on an iPhone 4s." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapped:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {

        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:@[[[UIMenuItem alloc] initWithTitle:@"Test 1" action:@selector(test)],
                             [[UIMenuItem alloc] initWithTitle:@"Test 2" action:@selector(test)],
                             [[UIMenuItem alloc] initWithTitle:@"Test 3" action:@selector(test)],
                             [[UIMenuItem alloc] initWithTitle:@"Test 4" action:@selector(test)]]];
        [menu setTargetRect:(CGRect){.origin=[gesture locationInView:self.view], .size=CGSizeMake(1, 1)} inView:self.view];
        [self becomeFirstResponder];
        [menu setMenuVisible:YES animated:YES];
    }
}

- (void)test {}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
