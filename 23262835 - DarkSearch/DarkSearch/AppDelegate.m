#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];

    UINavigationController *const navigation = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    navigation.navigationBar.barStyle = UIBarStyleBlack;

    // Use black to hide the search text.
    navigation.navigationBar.barTintColor = [UIColor blackColor];
    // Or use grey to hide the placeholder text, magnifying glass and clear button.
//    navigation.navigationBar.barTintColor = [UIColor colorWithWhite:0.57 alpha:1];

    navigation.navigationBar.tintColor = [UIColor whiteColor];

    [self.window setRootViewController:navigation];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
