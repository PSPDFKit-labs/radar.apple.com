//
//  ViewController.m
//  OverridingNavigationItemStoryboardFails
//
//  Created by Michael Ochs on 4/5/16.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UINavigationItem *_internalNavigationItem;
}

@end


@implementation ViewController

- (UINavigationItem *)navigationItem {
    if (_internalNavigationItem == nil) {
        UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:self.title];
        item.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:@"Test" style:UIBarButtonItemStylePlain target:nil action:NULL]];
        _internalNavigationItem = item;
    }
    return _internalNavigationItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSLog(@"\nsuper navigationItem:\t%@,\nself navigationItem:\t%@,\nnavigationBar topItem:\t%@", [self valueForKey:@"_navigationItem"], self.navigationItem, self.navigationController.navigationBar.topItem);
    if (self.navigationItem == self.navigationController.navigationBar.topItem) {
        NSLog(@"all good!");
    } else {
        NSLog(@"top navigation item should be %@ but is %@.", self.navigationItem, self.navigationController.navigationBar.topItem);
    }
}

@end
