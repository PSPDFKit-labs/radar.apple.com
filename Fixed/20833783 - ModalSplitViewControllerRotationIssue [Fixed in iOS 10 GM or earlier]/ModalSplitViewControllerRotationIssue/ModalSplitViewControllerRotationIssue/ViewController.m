//
//  ViewController.m
//  ModalSplitViewControllerRotationIssue
//
//  Created by Matej Bukovinski on 6. 05. 15.
//  Copyright (c) 2015 PSPDFKit. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed:)];
}

#pragma mark - Actions

- (void)donePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
