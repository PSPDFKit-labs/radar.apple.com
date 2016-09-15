#import "AppDelegate.h"
#import "FormPageOneViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIViewController *base = [[UIViewController alloc] init];
    [[base view] setBackgroundColor:[UIColor yellowColor]];

    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    [[self window] setRootViewController:base];
    [[self window] makeKeyAndVisible];

    dispatch_async(dispatch_get_main_queue(), ^{
        UINavigationController *formNavigationController = [[UINavigationController alloc] initWithRootViewController:[[FormPageOneViewController alloc] init]];
        [formNavigationController setModalPresentationStyle:UIModalPresentationFormSheet];
        [base presentViewController:formNavigationController animated:YES completion:NULL];
    });

    return YES;
}

@end
