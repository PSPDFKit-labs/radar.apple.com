#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@end

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>
@property (nonatomic) UIWindow * window;
@end

@interface TestViewController : UIViewController
@end

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

@implementation AppDelegate
@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindow *window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    window.rootViewController = [[TestViewController alloc] init];
    [window makeKeyAndVisible];
    self.window = window;
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.hoverStyle = nil; // no warning
    self.view.hoverStyle.enabled = NO; // no warning

    self.contentUnavailableConfiguration = nil; // warns as expected
    UIAccessibilityTraits traits = UIAccessibilityTraitToggleButton; // warns as expected
    UIShape *shape = [UIShape circleShape]; // warns as expected
    UIHoverStyle *hoverStyle = [UIHoverStyle styleWithShape:shape]; // warns as expected
}

@end
