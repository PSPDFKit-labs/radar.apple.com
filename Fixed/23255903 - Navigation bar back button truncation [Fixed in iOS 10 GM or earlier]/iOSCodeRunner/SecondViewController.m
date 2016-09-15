#import "SecondViewController.h"

@implementation SecondViewController

- (instancetype)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    self = [super initWithNibName:@"SecondView" bundle:nil];
    if (self == nil) return nil;

    [[self navigationItem] setLeftItemsSupplementBackButton:YES];
    [self toggleTitle:nil];

    return self;
}

- (NSString *)realTitle {
    return @"The Second";
}

- (IBAction)forceBarLayout:(id)sender {
    CGRect const frame = [[[self navigationController] navigationBar] frame];
    CGRect slightlyDifferentFrame = frame;
    ++slightlyDifferentFrame.size.width;
    [[[self navigationController] navigationBar] setFrame:slightlyDifferentFrame];
    [[[self navigationController] navigationBar] setFrame:frame];
}

- (IBAction)toggleTitle:(id)sender {
    if ([[self title] length]) {
        [self setTitle:nil];
        return;
    }
    [self setTitle:[self realTitle]];
}

- (IBAction)leftStepperChanged:(UIStepper *)sender {
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger count = 0; count < [sender value]; ++count) {
        [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:NULL]];
    }

    [[self navigationItem] setLeftBarButtonItems:items];
}

- (IBAction)rightStepperChanged:(UIStepper *)sender {
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger count = 0; count < [sender value]; ++count) {
        [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:NULL]];
    }

    [[self navigationItem] setRightBarButtonItems:items];
}

@end
