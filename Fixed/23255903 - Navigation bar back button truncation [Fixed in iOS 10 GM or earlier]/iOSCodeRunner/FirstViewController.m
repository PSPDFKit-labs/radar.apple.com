#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation FirstViewController {
    SecondViewController *_second;
}

- (instancetype)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    self = [super initWithNibName:nibName bundle:bundle];
    if (self == nil) return nil;

    [self setTitle:@"The First"];
    _second = [[SecondViewController alloc] init];

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self view] setBackgroundColor:[UIColor colorWithHue:0.15 saturation:0.8 brightness:0.7 alpha:1]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [[self navigationController] pushViewController:_second animated:YES];
}

@end
