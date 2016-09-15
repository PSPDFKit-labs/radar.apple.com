#import "FormPageTwoViewController.h"
#import "FormPageTwoView.h"

@interface FormPageTwoViewController ()

@property (nonatomic, strong) FormPageTwoView *view;

@end

@implementation FormPageTwoViewController

@dynamic view;

- (void)loadView {
    [self setView:[[FormPageTwoView alloc] init]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[[self view] textField] becomeFirstResponder];
}

@end
