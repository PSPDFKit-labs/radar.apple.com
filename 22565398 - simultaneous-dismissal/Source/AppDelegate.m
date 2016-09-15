#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    UINavigationController *const navigationController = [[UINavigationController alloc] init];
    [navigationController pushViewController:[[MasterViewController alloc] init] animated:NO];
    [navigationController pushViewController:[[DetailViewController alloc] init] animated:NO];

    self.window.rootViewController = navigationController;
	[self.window makeKeyAndVisible];
	
	return YES;
}

@end
