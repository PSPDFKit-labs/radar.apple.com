#import "ViewController.h"

@interface PSTPrinterContainerViewController : UIViewController <UIPrintInteractionControllerDelegate>
@end

@interface ViewController ()
@property UIPopoverController *popover;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.contentEdgeInsets = UIEdgeInsetsMake(50, 50, 50, 50);
    button.titleLabel.font = [UIFont systemFontOfSize:50];
    [button setTitle:@"Press me 3 times to crash" forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonPressed:(id)sender {
    NSLog(@"button pressed.");

    if (self.popover) {
        [self.popover dismissPopoverAnimated:NO];
        self.popover = nil;
        return;
    }

    PSTPrinterContainerViewController *printerContainerController = [PSTPrinterContainerViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:printerContainerController];
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:navController];
    popover.passthroughViews = @[self.view];
    [popover presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    self.popover = popover;
}

@end


@implementation PSTPrinterContainerViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // In our real app, we show UI here and then push the controller after pressing a button.
    // We would like to retain this behavior since it's nice to have the print controller inside the navigation controller.


    UIPrintInteractionController *printController = UIPrintInteractionController.sharedPrintController;
    printController.delegate = self;
    printController.printFormatter = [[UISimpleTextPrintFormatter alloc] initWithText:@"test"];

    // This also ensures we stick around until the completionHandler has been called.
    UIPrintInteractionCompletionHandler completionHandler = ^(UIPrintInteractionController *printInteractionController, BOOL completed, NSError *error) {
        if (error) {
            NSLog(@"Could not print document. %@", error);
        } else {
            NSLog(@"Printing finished: %d", completed);
        }
    };

    // Don't animate if we're skipping the settings controller immediately.
    //
    // This will show a warning that we can completely ignore:
    // WARNING: Calling -[UIPrintInteractionController presentAnimated:completionHandler:] on iPad
    if (![printController presentAnimated:animated completionHandler:completionHandler]) {
        NSLog(@"UIPrintInteractionController returned NO when trying to display.");
    }
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIPrinterPickerControllerDelegate

- (UIViewController *)printInteractionControllerParentViewController:(UIPrintInteractionController *)printInteractionController {
    return self.navigationController;
}

@end
