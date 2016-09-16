//
//  TestTableViewController.m
//  PopoverNavigationControllerSizingIssue
//
//  Created by Peter Steinberger on 08/12/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "TestTableViewController.h"
#import "KeyboardTableViewController.h"

@implementation TestTableViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    KeyboardTableViewController *controller = [KeyboardTableViewController new];
    [self.navigationController pushViewController:controller animated:YES];
    [controller performSelector:@selector(selectPasswordField) withObject:nil afterDelay:0.f];

}

@end
