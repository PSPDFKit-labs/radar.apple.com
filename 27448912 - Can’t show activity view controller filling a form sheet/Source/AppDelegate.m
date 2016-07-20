#import "AppDelegate.h"
#import "FirstViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] init];
	self.window.rootViewController = [[FirstViewController alloc] init];
	[self.window makeKeyAndVisible];
	
	return YES;
}

@end
