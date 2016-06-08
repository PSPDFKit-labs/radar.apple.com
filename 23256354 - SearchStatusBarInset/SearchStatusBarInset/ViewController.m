#import "ViewController.h"
#import "TableViewController.h"

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    self = [super initWithNibName:nibName bundle:bundle];
    if (self == nil) return nil;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showTable:)];

    return self;
}

- (void)loadView {
    UILabel *const label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    label.text = @"   On iPad Air 2:\n"
    @"   1. Rotate to landscape\n"
    @"   2. Enter Split Screen, with this app in the larger split\n"
    @"   3. Tap the bookmarks button in the top-right";

    self.view = label;
}

- (void)showTable:(id)sender {
    UIViewController *const navigationController = [[UINavigationController alloc] initWithRootViewController:[[TableViewController alloc] init]];

    navigationController.modalPresentationStyle = UIModalPresentationPopover;
    navigationController.popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem;

    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
