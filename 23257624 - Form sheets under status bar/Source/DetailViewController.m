#import "DetailViewController.h"

@implementation DetailViewController

- (NSString *)title {
    return @"Detail";
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

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:NULL];

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
}

- (void)handleTap:(UIGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#define SPECIFY_CONTENT_SIZE 0
#if SPECIFY_CONTENT_SIZE
- (CGSize)preferredContentSize {
    return CGSizeMake(400, 300);
}
#endif

@end
