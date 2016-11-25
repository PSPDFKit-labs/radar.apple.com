//
//  ViewController.m
//  UserInteractionInNavBar
//
//  Created by Michael Ochs on 11/25/16.
//  Copyright © 2016 PSPDFKit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) UIBarButtonItem *barButtonItem;
@property (nonatomic) UIBarButtonItem *otherBarButtonItem;

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        self.barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

        self.otherBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:NULL];

        self.navigationItem.rightBarButtonItems = @[self.barButtonItem, self.otherBarButtonItem];
    }
    return self;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
        [self.navigationItem setRightBarButtonItems:@[self.barButtonItem] animated:YES];
    } else {
        [self.navigationItem setRightBarButtonItems:@[self.barButtonItem, self.otherBarButtonItem] animated:YES];
    }
}

- (IBAction)buttonTapped:(id)sender {
    // deprecated, but much shorter for a debugging alert...
    [[[UIAlertView alloc] initWithTitle:@"Tapped" message:@"Tapping worked!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

@end
