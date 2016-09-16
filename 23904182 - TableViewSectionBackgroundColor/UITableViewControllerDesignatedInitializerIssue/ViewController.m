//
//  ViewController.m
//  UITableViewSectionBackgroundColorIssue
//
//  Created by Peter Steinberger on 15/04/15.
//  Copyright (c) 2015 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@interface SampleTableViewController : UITableViewController
@end

@implementation SampleTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // BUG: Uncomment to fix the section colors.
    // This is a getter - should not have side effects (but it reloads the cells if frame is different...)
  //  [self.tableView visibleCells];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TestCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = indexPath.description;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%tu Section", section];
}

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    SampleTableViewController *controller = [[SampleTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:controller] animated:YES completion:^{
        [[[UIAlertView alloc] initWithTitle:@"Section Color Bug" message:@"Querying for visible cells in viewWillAppear: breaks the logic that colors the section views - they are white when they should be gray. Uncomment the call to [self.tableView visibleCells] in viewWillAppear: to work around the issue. This is a regression in iOS 9 - works fine in iOS 8." delegate:nil cancelButtonTitle:@"Oh well, state bugs are fun!" otherButtonTitles:nil] show];
    }];
}

@end
