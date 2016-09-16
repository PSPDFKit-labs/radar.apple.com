#import "ViewController.h"
#import "TestTableViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIPopoverController *popover;
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // Show the red popover
    UIViewController *controller = [TestTableViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];

    // Use this to test iOS 7 instead.
//    self.popover = [[UIPopoverController alloc] initWithContentViewController:navController];
//    [self.popover presentPopoverFromRect:CGRectMake(200.f, 200.f, 1.f, 1.f) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

    navController.modalPresentationStyle = UIModalPresentationPopover;
    navController.popoverPresentationController.sourceView = self.view;
    navController.popoverPresentationController.sourceRect = CGRectMake(200.f, 200.f, 1.f, 1.f);

    [self presentViewController:navController animated:YES completion:^{
        // Show an alert to explain the radar
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Radar" message:@"Hiding the navigation bar should reflect a popover size change if preferredContentSize is set again, however this doesn't work." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:NULL]];
        [navController presentViewController:alert animated:YES completion:NULL];
    }];



}
@end
