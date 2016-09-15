#import "FirstViewController.h"

@implementation FirstViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.preferredContentSize = CGSizeMake(320.f, 400.f);
}

- (IBAction)resizePressed:(id)sender {
	if (CGSizeEqualToSize(self.preferredContentSize, CGSizeMake(320.f, 400.f))) {
		self.preferredContentSize = CGSizeMake(320.f, 500.f);
	} else {
		self.preferredContentSize = CGSizeMake(320.f, 400.f);
	}
}

@end
