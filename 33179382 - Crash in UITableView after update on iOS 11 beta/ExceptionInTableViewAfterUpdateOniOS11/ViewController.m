//
//  ViewController.m
//  ExceptionInTableViewAfterUpdateOniOS11
//
//  Created by Konstantin Bender on 07.07.17.
//  Copyright © 2017 Konstantin Bender. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray* items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem.target = self;
    self.navigationItem.rightBarButtonItem.action = @selector(toggleEdit:);
    self.items = @[@"Item"];
    [self.tableView reloadData];
}

#pragma mark - Actions

- (void)toggleEdit:(id)sender {
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableView beginUpdates];
        NSMutableArray *const items = [self.items mutableCopy];
        [items removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        self.items = items;
        [self.tableView endUpdates];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *const cell = [tableView dequeueReusableCellWithIdentifier:@"item" forIndexPath:indexPath];
    cell.textLabel.text = self.items[indexPath.row];
    return cell;
}

@end
