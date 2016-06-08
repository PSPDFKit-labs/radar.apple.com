#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController () <UIAdaptivePresentationControllerDelegate>

@end

@implementation MasterViewController

- (void)loadView {
    UILabel *const label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithHue:0.5 saturation:0.2 brightness:0.9 alpha:1];
    label.numberOfLines = 0;
    label.text = @"Tap to present a form sheet.";
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
    UINavigationController *const navigationController = [[UINavigationController alloc] initWithRootViewController:detail];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    navigationController.presentationController.delegate = self;

    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - UIAdaptivePresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

@end
