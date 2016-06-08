//
//  ViewController.m
//  Fullscreen
//
//  Created by Matthias Plappert on 06/11/14.
//  Copyright (c) 2014 Matthias Plappert. All rights reserved.
//

#import "ViewController.h"
#import "ChildViewController.h"

@interface FullscreenWindow : UIWindow @end
@implementation FullscreenWindow

- (void)setRootViewController:(UIViewController *)rootVC {
    // Try to clear the existing interface orientation, fixes rdar://18906964.
    // Apparantly in iOS 8.1 the interface orientation doesn't correctly clears out,
    // which then leads to weird rotation issues.
    @try {[rootVC setValue:@(UIInterfaceOrientationPortrait) forKey:NSStringFromSelector(@selector(interfaceOrientation))];}
    @catch (NSException *exception) {}
    [super setRootViewController:rootVC];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:UIScreen.mainScreen.bounds];
}

@end

@interface ViewController ()

@property (nonatomic, strong) ChildViewController *childController;
@property (nonatomic, strong) UIWindow *fullscreenWindow;

@end

@implementation ViewController

- (instancetype)init {
    return [super initWithNibName:@"ViewController" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.childController = [[ChildViewController alloc] init];
    [self addChildViewController:self.childController];
    self.childController.view.frame = self.containerView.bounds;
    [self.containerView addSubview:self.childController.view];
    [self.childController didMoveToParentViewController:self];
}

- (IBAction)transitionByUsingNewController:(id)sender {
    NSLog(@"Using new controller");
    self.fullscreenWindow = [self newWindow];
    self.fullscreenWindow.rootViewController = [[ChildViewController alloc] init];
    [self.fullscreenWindow makeKeyAndVisible];
}

- (IBAction)transitionByReUsingController:(id)sender {
    NSLog(@"Re-using existing controller");
    self.fullscreenWindow = [self newWindow];
    [self.childController willMoveToParentViewController:nil];
    [self.childController.view removeFromSuperview];
    [self.childController removeFromParentViewController];

    [self.childController setValue:@(UIInterfaceOrientationPortrait) forKey:@"interfaceOrientation"];

    self.fullscreenWindow.rootViewController = self.childController;
    [self.fullscreenWindow makeKeyAndVisible];

    //[self.fullscreenWindow setValue:@YES forKey:@"autorotates"];
}

- (UIWindow *)newWindow {
    UIWindow *window = [[FullscreenWindow alloc] init];
    window.windowLevel = UIWindowLevelAlert;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissFullscreen)];
    [window addGestureRecognizer:recognizer];
    return window;
}

- (void)dismissFullscreen {
    self.fullscreenWindow.rootViewController = nil;
    self.fullscreenWindow = nil;
    [self.view.window makeKeyAndVisible];
}

@end
