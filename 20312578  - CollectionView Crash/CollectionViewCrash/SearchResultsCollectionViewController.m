//
//  SearchResultsCollectionViewController.m
//  CollectionViewCrash
//
//  Created by Patrik Weiskircher on 3/25/15.
//  Copyright (c) 2015 Patrik Weiskircher. All rights reserved.
//

#import "SearchResultsCollectionViewController.h"

@interface SearchResultsCollectionViewController ()

@end

@implementation SearchResultsCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

@end
