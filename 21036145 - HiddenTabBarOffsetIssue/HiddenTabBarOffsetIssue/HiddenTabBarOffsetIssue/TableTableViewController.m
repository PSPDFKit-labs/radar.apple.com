//
//  TableTableViewController.m
//  HiddenTabBarOffsetIssue
//
//  Created by Matej Bukovinski on 20. 05. 15.
//  Copyright (c) 2015 PSPDFKit. All rights reserved.
//

#import "TableTableViewController.h"

@interface TableTableViewController ()

@end

@implementation TableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    self.title = @"3. Scroll to the bottom ↓";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    if (indexPath.row == 9) {
        cell.textLabel.text = @"See gap below! ↓";
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    }
    return cell;
}

@end
