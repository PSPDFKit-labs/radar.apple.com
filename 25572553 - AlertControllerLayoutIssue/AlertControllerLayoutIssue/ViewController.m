//
//  ViewController.m
//  AlertControllerLayoutIssue
//
//  Created by Peter Steinberger on 06/04/16.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.blueColor;

    NSLog(@"Hey there! Press the button and see how the action sheet doesn't lay itself out correct.");

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Davros must be honoured!" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = UIColor.blackColor;
    [button sizeToFit];
    self.button = button;

    [self.view addSubview:button];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    const CGFloat size = 300.f;
    const CGRect bounds = self.view.bounds;
    self.button.frame = CGRectMake(bounds.size.width-size, (bounds.size.height-size)/2.f, size, size);
}

- (void)buttonTapped:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"EXTERMINATE! EXTERMINATE!" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"He must be exterminated! Nothing must interfere with the true destiny of the Daleks!! You must be exterminated! Exterminated! EXTERMINATED!! [destroys the second Dalek]");
    }]];
    alertController.popoverPresentationController.sourceView = sender;
    [self presentViewController:alertController animated:YES completion:NULL];
}

@end
