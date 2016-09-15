//
//  DetailViewController.m
//  Restore
//
//  Created by Daniel on 11.02.15.
//  Copyright (c) 2015 Daniel. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
}

- (void)configureView {
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

static NSString * const DetailItemKey = @"Detail Item";
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    // Yeah okay I shouldn’t store my “model” in the coder, but this is a demo…
    [coder encodeObject:self.detailItem forKey:DetailItemKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    // Yeah okay I shouldn’t store my “model” in the coder, but this is a demo…
    self.detailItem = [coder decodeObjectForKey:DetailItemKey];
}

- (IBAction)dismissViaUnwind:(UIStoryboardSegue *)sender {}

@end
