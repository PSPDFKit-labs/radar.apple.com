#import "ViewController.h"

@implementation ViewController

#pragma mark - Lifecycle

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

     NSLog(@"viewWillLayoutSubviews: %f", self.bottomLayoutGuide.length);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    NSLog(@"viewDidLayoutSubviews: %f", self.bottomLayoutGuide.length);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"viewDidLayoutSubviews - afer dispatch_async: %f", self.bottomLayoutGuide.length);
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"viewDidLayoutSubviews - after 0.1s: %f", self.bottomLayoutGuide.length);
    });
}

@end
