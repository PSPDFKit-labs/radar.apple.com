#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    [self.window makeKeyAndVisible];

    // Comment out either of that to NOT crash.
    [[UINavigationBar appearance] setTintColor:UIColor.blueColor];
    [[UITextField appearance] setTintColor:UIColor.whiteColor];

    return YES;
}

@end
