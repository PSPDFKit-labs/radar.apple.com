//
//  KeyboardTableViewController.m
//  PopoverLoop
//
//  Created by Peter Steinberger on 22/01/15.
//  Copyright (c) 2015 PSPDFKit GmbH. All rights reserved.
//

#import "KeyboardTableViewController.h"

@interface KeyboardTableViewController ()
@property (nonatomic, strong) UITextField *passwordField;
@end

@implementation KeyboardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Everything is frozen!";
    self.preferredContentSize = CGSizeMake(300, 50);
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(0.f, 0.f, 160.f, 50.f)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    });
}

- (void)selectPasswordField {
    [self.passwordField becomeFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.accessoryView = self.passwordField;
    return cell;
}

@end
