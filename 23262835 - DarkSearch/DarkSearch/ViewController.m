#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) UISearchController *searchController;
@property (nonatomic) UITableViewController *resultsController;

@property (nonatomic) NSArray *steps;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.definesPresentationContext = YES;

    self.resultsController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsController];

    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;

    // Use private API or subview hacking to access the search bar’s text field.
//    UITextField *textField = [self.searchController.searchBar valueForKey:@"searchField"];
//    textField.textColor = [UIColor whiteColor];

    self.navigationItem.titleView = self.searchController.searchBar;

    // Decoration
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:nil action:NULL];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:NULL];
}

@end
