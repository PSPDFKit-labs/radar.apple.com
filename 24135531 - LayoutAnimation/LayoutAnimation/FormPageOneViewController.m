#import "FormPageOneViewController.h"
#import "FormPageTwoViewController.h"

@implementation FormPageOneViewController

- (void)loadView {
    UILabel *label = [[UILabel alloc] init];
    [label setText:@"Tap to push page two"];
    [label setBackgroundColor:[UIColor cyanColor]];
    [label setTextAlignment:NSTextAlignmentCenter];

    [label setUserInteractionEnabled:YES];
    [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];

    [self setView:label];
}

- (void)handleTap:(id)sender {
    FormPageTwoViewController *pageTwo = [[FormPageTwoViewController alloc] init];
    [[self navigationController] pushViewController:pageTwo animated:YES];
}

@end
