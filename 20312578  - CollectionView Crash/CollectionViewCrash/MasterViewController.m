//
//  MasterViewController.m
//  CollectionViewCrash
//
//  Created by Patrik Weiskircher on 3/25/15.
//  Copyright (c) 2015 Patrik Weiskircher. All rights reserved.
//

#import "MasterViewController.h"
#import "SearchResultsCollectionViewController.h"

@interface MasterViewController ()

@property (nonatomic) UISearchController *searchController;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SearchResultsCollectionViewController *searchResultsController = [[SearchResultsCollectionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];

    _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    [self.searchController.searchBar sizeToFit];
    [self.collectionView addSubview:self.searchController.searchBar];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    SearchResultsCollectionViewController *vc = (SearchResultsCollectionViewController*)self.searchController.searchResultsController;
    vc.objects = @[ @1, @2 ];
    [vc.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0], [NSIndexPath indexPathForRow:1 inSection:0]]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
