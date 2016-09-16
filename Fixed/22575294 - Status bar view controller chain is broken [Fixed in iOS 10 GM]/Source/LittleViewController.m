#import "LittleViewController.h"
#import "BigViewController.h"

@implementation LittleViewController

- (CGSize)preferredContentSize {
    return CGSizeMake(200, 200);
}

- (void)loadView {
    UILabel *const label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithHue:0 saturation:0.1 brightness:1 alpha:1];
    label.numberOfLines = 0;
    label.text = @"Tap to show a full screen view.";
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;

    self.view = label;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
}

- (void)handleTap:(UIGestureRecognizer *)sender {
    BigViewController *const big = [[BigViewController alloc] init];
    [self presentViewController:big animated:YES completion:nil];
}

@end
