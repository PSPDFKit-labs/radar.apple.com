#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIDocumentInteractionController *documentInteractionController;
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSURL *fileURL = [[[NSBundle mainBundle] bundleURL] URLByAppendingPathComponent:@"12985EN.pdf"];
    self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    [self.documentInteractionController presentOptionsMenuFromRect:CGRectZero inView:self.view animated:animated];

    // Does not throw the crazy amout of log statements
    //[self.documentInteractionController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:animated];
}

@end
