#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setWindow:[[UIWindow alloc] init]];
    [[self window] setRootViewController:[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]]];
    [[self window] makeKeyAndVisible];

    return YES;
}

@end
