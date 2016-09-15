#import "DetailViewController.h"

@implementation DetailViewController

- (instancetype)initWithCoder:(NSCoder *)decoder {
    return [super initWithCoder:decoder];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self init];
}

- (instancetype)init {
    return [super initWithNibName:nil bundle:nil];
}

- (void)loadView {
    UILabel *const label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithHue:0 saturation:0.2 brightness:0.7 alpha:1];
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
