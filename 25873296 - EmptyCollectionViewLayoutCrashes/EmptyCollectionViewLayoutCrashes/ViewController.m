//
//  ViewController.m
//  EmptyCollectionViewLayoutCrashes
//
//  Created by Michael Ochs on 4/22/16.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@interface MyLayout : UICollectionViewLayout

@end

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    layout = [MyLayout new];
    return [super initWithCollectionViewLayout:layout];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

@end


@implementation MyLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGSizeEqualToSize(self.collectionView.bounds.size, newBounds.size);
}

- (UICollectionViewLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds {
    UICollectionViewLayoutInvalidationContext *context = [super invalidationContextForBoundsChange:newBounds];
    if (!CGSizeEqualToSize(self.collectionView.bounds.size, newBounds.size)) {
        [context invalidateSupplementaryElementsOfKind:UICollectionElementKindSectionHeader atIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
    }
    return context;
}

@end
