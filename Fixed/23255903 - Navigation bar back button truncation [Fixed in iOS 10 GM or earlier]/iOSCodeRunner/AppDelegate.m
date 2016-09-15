#import "AppDelegate.h"
#import "FirstViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setWindow:[[UIWindow alloc] init]];

    FirstViewController *const first = [[FirstViewController alloc] init];
    UINavigationController *const navigation = [[UINavigationController alloc] initWithRootViewController:first];

    [[self window] setRootViewController:navigation];
    [[self window] makeKeyAndVisible];

    return YES;
}

@end
