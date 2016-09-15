#import "AppDelegate.h"

#import "MasterViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] init];
	self.window.rootViewController = [[MasterViewController alloc] init];
	[self.window makeKeyAndVisible];
	
	return YES;
}

@end
