//
//  TableViewController.m
//  EditingCrashExample
//
//  Created by Konstantin Bender on 5/29/17.
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Radar" message:@"Tap Edit\nTap in one of the text fields to begin editing\nTap Done" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Oh damn, another 💥" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"test" forIndexPath:indexPath];
}

@end
