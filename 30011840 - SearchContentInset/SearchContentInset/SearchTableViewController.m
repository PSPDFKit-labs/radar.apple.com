//
//  SearchTableViewController.m
//  SearchContentInset
//
//  Created by Michael Ochs on 1/13/17.
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController () <UISearchResultsUpdating>

@property (nonatomic) UISearchController *searchController;

@end


@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableViewController *searchResultsController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    searchResultsController.tableView.dataSource = self;
    searchResultsController.tableView.delegate = self;
    [searchResultsController.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];

    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    searchController.searchResultsUpdater = self;
    self.searchController = searchController;

    self.tableView.tableHeaderView = searchController.searchBar;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString localizedStringWithFormat:@"Section: %tu, row: %tu", indexPath.section, indexPath.row];
    return cell;
}


#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // irrelevant for the purpose of illustrating the bug
}

@end
