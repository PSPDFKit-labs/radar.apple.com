#import "TestTableViewController.h"

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"TestCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // Size the popover to fit height.
    [self.tableView reloadData]; // It also works if we comment this out.
    self.preferredContentSize = self.tableView.contentSize;

    // Now we hide the navigation bar, but the result is a popover size that is too large.
    self.navigationController.navigationBarHidden = YES;

    // Has no effect, can be commented.
    self.preferredContentSize = self.tableView.contentSize;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %tu", indexPath.row];
    return cell;
}

@end
