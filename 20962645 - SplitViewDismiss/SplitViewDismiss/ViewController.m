#import "ViewController.h"

@interface PSCSplitViewController : UISplitViewController <UISplitViewControllerDelegate>
@property (nonatomic) UIViewController *documentPicker;
@property (nonatomic) UIBarButtonItem *backToCatalogButton;
@property (nonatomic) UIPopoverController *masterPopoverController;
@end

@interface PSCSplitViewControllerContainer : UIViewController
@property (nonatomic, readonly) PSCSplitViewController *splitViewController;
@end

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    PSCSplitViewControllerContainer *container = [PSCSplitViewControllerContainer new];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:container] animated:YES completion:^{
        [[[UIAlertView alloc] initWithTitle:@"Radar" message:@"Now swipe right to show the master view controller and press Close. Observe crash" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Will do!", nil] show];
    }];
}

@end


@implementation PSCSplitViewController

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.preferredDisplayMode = UISplitViewControllerDisplayModeAutomatic;

        // Create global back button
        self.backToCatalogButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(backToCatalog:)];

        // Create the document picker
        self.documentPicker = [UIViewController new];
        self.documentPicker.view.backgroundColor = UIColor.yellowColor;

        // Put the document picker in a wrapper that extends under the navigation bar
        self.documentPicker.navigationItem.leftBarButtonItems = @[self.backToCatalogButton];
        UINavigationController *documentWrapper = [[UINavigationController alloc] initWithRootViewController:self.documentPicker];
        documentWrapper.definesPresentationContext = YES;

        // Set up split view controller set.
        self.viewControllers = @[documentWrapper, [UIViewController new]];
        self.delegate = self;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private

- (void)backToCatalog:(id)sender {
    // HACK HACK HACK - fixes the crash.
    // Since a split screen view really doesn't like being presented modally, there's no logic that would dismiss the popover.
    // We manually have to dig in and get the variable.
//    @try { [[self valueForKey:@"_hiddenPopoverController"] dismissPopoverAnimated:NO]; }
//    @catch (__unused NSException *exception) {}

    [self.parentViewController dismissViewControllerAnimated:YES completion:NULL];
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UISplitViewControllerDelegate

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    return YES;
}

- (UIViewController *)primaryViewControllerForExpandingSplitViewController:(UISplitViewController *)splitViewController {
    return self.documentPicker.parentViewController;
}

@end


@implementation PSCSplitViewControllerContainer

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        PSCSplitViewController *splitViewController = [PSCSplitViewController new];
        [self addChildViewController:splitViewController];
        [self.view addSubview:splitViewController.view];
        splitViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [splitViewController didMoveToParentViewController:self];
        _splitViewController = splitViewController;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.splitViewController.viewControllers.lastObject;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.splitViewController.viewControllers.lastObject;
}

@end
