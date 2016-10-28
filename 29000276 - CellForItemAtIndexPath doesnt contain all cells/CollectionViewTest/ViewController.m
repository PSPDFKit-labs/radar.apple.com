//
//  ViewController.m
//  CollectionViewTest
//
//  Created by Michael Ochs on 5/23/16.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    // configure cell, e.g. in a loading state
    cell.backgroundColor = [UIColor colorWithRed:0.7 green:0.3 blue:0.3 alpha:1.0]; // red

    // start fetching stuff
    dispatch_async(dispatch_get_main_queue(), ^{
        // hey look, what we were trying to fetch was in the cache, so it was delivered
        // already at the end of the current run loop cycle...
        // let's update the cell...
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:1.0 alpha:1.0]; // blue
    });

    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


@end
