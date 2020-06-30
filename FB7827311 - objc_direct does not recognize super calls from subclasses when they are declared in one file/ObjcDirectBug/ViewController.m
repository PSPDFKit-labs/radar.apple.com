//
//  ViewController.m
//  ObjcDirectBug
//
//  Created by Peter Steinberger on 30.06.20.
//

#import "ViewController.h"
#import "ToolbarButton.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    PSPDFToolbarTickerButton *button = [[PSPDFToolbarTickerButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [button setTitle:@"Tap me!" forState:UIControlStateNormal];
    [self.view addSubview:button];


    // If PSPDFToolbarTickerButton is annotated with PSPDF_OBJC_DIRECT_MEMBERS,
    // then this block is not executed, as the touchDown/touchUp methods are directed.

    // This only works because things are declared in the same file.
    [button setActionBlock:^(PSPDFButton *button) {
        NSLog(@"I should print when tapping!");
    } forControlEvents:PSPDFControlEventTouchUpInsideIfNotTicking | PSPDFControlEventTick];

}

@end
