#import "MasterViewController.h"
#import "DetailViewController.h"

@implementation MasterViewController

- (NSString *)title {
    return @"Master";
}

- (void)loadView {
    UILabel *const label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithHue:0.5 saturation:0.4 brightness:0.3 alpha:1];
    label.numberOfLines = 0;
    label.text = @"Tap to push detail view controller.";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.userInteractionEnabled = YES;

    self.view = label;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
}

- (void)handleTap:(UIGestureRecognizer *)sender {
    [self.navigationController pushViewController:[[DetailViewController alloc] init] animated:YES];
}

@end
