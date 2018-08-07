//
//  ViewController.m
//  DragAndDropTest
//
//  Created by Oscar Swanros on 8/7/18.
//  Copyright © 2018 Oscar Swanros. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController () <UICollectionViewDragDelegate, UICollectionViewDelegateFlowLayout>

@end


@implementation ViewController

- (void)loadView {
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [self.collectionView registerClass:UICollectionViewCell.self forCellWithReuseIdentifier:@"Cell"];
    self.collectionView.dragDelegate = self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

#///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Data Source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"doggo"]];

    return cell;
}

#///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Flow Layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(130, 130);
}

#///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Drag Delegate

- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath {
    NSItemProvider *provider = [[NSItemProvider alloc] init];

    NSFileManager *fileManager = [NSFileManager defaultManager];

    [provider registerFileRepresentationForTypeIdentifier:(NSString *)kUTTypePNG fileOptions:0 visibility:NSItemProviderRepresentationVisibilityAll loadHandler:^NSProgress * _Nullable(void (^ _Nonnull completionHandler)(NSURL * _Nullable, BOOL, NSError * _Nullable)) {
        UIImage *image = [UIImage imageNamed:@"doggo"];
        NSURL *docsDir = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
        NSURL *finalURL = [docsDir URLByAppendingPathComponent:@"doggo.png"];

        [fileManager createFileAtPath:finalURL.path contents:UIImagePNGRepresentation(image) attributes:nil];

        completionHandler(finalURL, YES, nil);

        return nil;
    }];

    [provider registerFileRepresentationForTypeIdentifier:(NSString *)kUTTypePDF fileOptions:0 visibility:NSItemProviderRepresentationVisibilityAll loadHandler:^NSProgress * _Nullable(void (^ _Nonnull completionHandler)(NSURL * _Nullable, BOOL, NSError * _Nullable)) {
        NSURL *docsDir = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
        NSURL *finalURL = [docsDir URLByAppendingPathComponent:@"doggo.pdf"];

        [fileManager createFileAtPath:finalURL.path contents:[[NSDataAsset alloc] initWithName:@"doggo_data"].data attributes:nil];

        completionHandler(finalURL, YES, nil);

        return nil;
    }];

    return @[[[UIDragItem alloc] initWithItemProvider:provider]];
}

- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForAddingToDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point {
    return @[[[UIDragItem alloc] initWithItemProvider:[NSItemProvider new]]];
}

@end
