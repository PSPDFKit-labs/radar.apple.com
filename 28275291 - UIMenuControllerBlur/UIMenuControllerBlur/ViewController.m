#import "ViewController.h"

@interface ViewController () @end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor blueColor] CGColor], nil];
    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);
    [view.layer insertSublayer:gradient atIndex:0];
    [self.view addSubview:view];

    UILabel *tapLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    tapLabel.text = @"Tap here";
    [self.view addSubview:tapLabel];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    [[UIMenuController sharedMenuController] setTargetRect:CGRectMake(100, 100, 100, 100) inView:self.view];
    UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"Now tap me!" action:@selector(customAction:)];
    [[UIMenuController sharedMenuController] setMenuItems:@[menuItem]];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)customAction:(id)sender {
    // Comment out the next line and the blur will be gone! But we kinda like that line!
    [[UIMenuController sharedMenuController] setTargetRect:CGRectMake(100, 100, 100, 100) inView:self.view];

    UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"Do you see this ugly blur beneath me?" action:@selector(customAction:)];
    [[UIMenuController sharedMenuController] setMenuItems:@[menuItem]];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

@end
