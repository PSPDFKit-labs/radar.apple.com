#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () <UIViewControllerTransitioningDelegate>

@end

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
    detail.modalPresentationStyle = UIModalPresentationCustom;
    detail.transitioningDelegate = self;

    [self presentViewController:detail animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    NSAssert(presented, @"presented is nil");
    NSAssert(presenting, @"presenting is nil");
    NSAssert(source, @"source is nil");

    return nil;
}

@end
