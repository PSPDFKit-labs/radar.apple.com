#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation FirstViewController

- (void)loadView {
    UILabel *const label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithHue:0.5 saturation:0.4 brightness:0.9 alpha:1];
    label.text = @"Tap to present a form sheet.";
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];

    self.view = label;
}

- (void)handleTap:(UIGestureRecognizer *)sender {
    UIViewController *const viewController = [[SecondViewController alloc] init];
    viewController.modalPresentationStyle = UIModalPresentationFormSheet;

    [self presentViewController:viewController animated:YES completion:nil];
}

@end
