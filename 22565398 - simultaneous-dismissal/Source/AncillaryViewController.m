#import "AncillaryViewController.h"

@implementation AncillaryViewController

- (CGSize)preferredContentSize {
    return CGSizeMake(320, 320);
}

- (void)loadView {
    UILabel *const label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithHue:0 saturation:0.1 brightness:1 alpha:1];
    label.numberOfLines = 0;
    label.text = @"Tap to dismiss this view controller.";
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;

    self.view = label;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
}

- (void)handleTap:(UIGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
