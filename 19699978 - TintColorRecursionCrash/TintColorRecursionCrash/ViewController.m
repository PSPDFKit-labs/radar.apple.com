#import "ViewController.h"

@interface TestView : UIView @end

@implementation TestView

- (void)tintColorDidChange {
    [super tintColorDidChange];

    // THIS IS BAD - but only in combination with UIAppearance.
    self.tintColor = self.tintColor;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    TestView *testView = [[TestView alloc] initWithFrame:CGRectZero];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:testView];
}

@end
