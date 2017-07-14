//
//  PSPDFStackViewLayout.m
//  ViewHierarchy
//
//  Created by Michael Ochs on 7/13/17.
//  Copyright © 2017 PSPDFKit GmbH. All rights reserved.
//

#import "PSPDFFullscreenStackViewLayout.h"

@implementation PSPDFFullscreenStackViewLayout

- (CGSize)collectionViewContentSize {
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    if (numberOfItems == 0) { return CGSizeZero; }

    UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:numberOfItems-1 inSection:0]];
    CGSize size = CGSizeZero;
    size.width = CGRectGetMaxX(attribute.frame) + self.margins.right;
    size.height = CGRectGetMaxY(attribute.frame) + self.margins.bottom;
    return size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect frame = (CGRect){.size = self.itemSize};
    frame.origin.x = self.margins.left;
    frame.origin.y = self.margins.top + (self.itemSize.height + self.interItemSpacing) * indexPath.item;

    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.frame = frame;
    return attribute;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGFloat itemHeight = self.itemSize.height;
    NSInteger firstItem = MAX(0, (NSInteger)((CGRectGetMinY(rect) - self.margins.top) / (itemHeight + self.interItemSpacing)));

    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [NSMutableArray new];
    for (NSInteger item = firstItem; item < [self.collectionView numberOfItemsInSection:0] ; item++) {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0]];
        if (CGRectGetMinY(attribute.frame) > CGRectGetMaxY(rect)) { break; }
        [attributes addObject:attribute];
    }
    return attributes;
}


#pragma mark - Setter

- (void)setMargins:(UIEdgeInsets)margins {
    _margins = margins;
    [self invalidateLayout];
}

- (void)setInterItemSpacing:(CGFloat)interItemSpacing {
    _interItemSpacing = interItemSpacing;
    [self invalidateLayout];
}

- (void)setItemSize:(CGSize)itemSize {
    _itemSize = itemSize;
    [self invalidateLayout];
}

@end
