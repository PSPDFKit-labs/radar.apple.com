#import "MasterViewController.h"

#import "DetailViewController.h"
#import "UIView+PSPDFKitAdditions.h"

@implementation MasterViewController

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
    label.backgroundColor = [UIColor colorWithHue:0.5 saturation:0.4 brightness:0.7 alpha:1];
    label.numberOfLines = 0;
    label.text = @"Tap to present another view controller.";
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;

    self.view = label;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
}

- (void)handleTap:(UIGestureRecognizer *)sender {
    UIViewController *const detail = [[DetailViewController alloc] init];

    [self presentViewController:detail animated:YES completion:^{
        NSSet<__kindof UIView *> *const allSubviews = detail.presentationController.containerView.pspdf_recursiveSubviews;
        NSAssert([allSubviews containsObject:detail.view], @"Presentation controller container view is not an ancestor of the presented view controller’s view.");
        NSAssert([allSubviews containsObject:self.view], @"Presentation controller container view is not an ancestor of the presenting view controller’s view.");

    }];
}

@end
