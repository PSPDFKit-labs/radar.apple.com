#import "ViewController.h"
#import "CustomCell.h"

#define let __auto_type const

static let standardCellIdentifier = @"standard";
static let customCellIdentifier = @"custom";

@implementation ViewController {
    NSNumberFormatter *_formatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _formatter = [[NSNumberFormatter alloc] init];
    _formatter.numberStyle = NSNumberFormatterSpellOutStyle;

    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:standardCellIdentifier];
    [self.tableView registerClass:CustomCell.class forCellReuseIdentifier:customCellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    let text = [_formatter stringFromNumber:@(indexPath.row + 12345678)];

    if (indexPath.row % 2) {
        let cell = [tableView dequeueReusableCellWithIdentifier:standardCellIdentifier forIndexPath:indexPath];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = text;
        return cell;
    } else {
        CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:customCellIdentifier forIndexPath:indexPath];
        cell.customLabel.text = text;
        return cell;
    }
}

@end
