#import "TableViewController.h"

@interface TableViewController ()

@property (nonatomic) UISearchController *searchController;
@property (nonatomic) UITableViewController *resultsController;

@property (nonatomic) NSArray *steps;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.resultsController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsController];

    self.tableView.tableHeaderView = self.searchController.searchBar;

    self.steps = @[
                   @"4. Tap the search field",
                   @"5. Rotate to portrait",
                   @"6. Tap the cancel button",
                   @"Notice the extra top inset",
                   ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.steps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *const cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = self.steps[indexPath.row];
    return cell;
}

@end
