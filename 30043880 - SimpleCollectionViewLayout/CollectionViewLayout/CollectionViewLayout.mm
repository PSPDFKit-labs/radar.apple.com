//
//  CollectionViewLayout.m
//  CollectionViewLayout
//
//  Created by Michael Ochs on 1/12/17.
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

#import "CollectionViewLayout.h"
#import <map>
#import <mutex>


@interface CollectionViewLayout ()

@property (nonatomic) NSMutableArray<UICollectionViewLayoutAttributes *> *knownLayoutAttributes;

@end


const UIEdgeInsets SectionInset = {10.0, 10.0, 10.0, 10.0};
const CGFloat InterItemSpacing = 10.0;
const CGFloat LineSpacing = 10.0;
const CGFloat ItemHeight = 450.0;


@implementation CollectionViewLayout

#pragma mark - Lifecycle

- (instancetype)init {
    if ((self = [super init])) {
        _knownLayoutAttributes = [NSMutableArray new];
    }
    return self;
}


#pragma mark - CollectionView Callbacks

- (CGSize)collectionViewContentSize {
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    NSInteger rows = ceilf(items / 4.0);
    CGFloat height = SectionInset.top + rows * (ItemHeight + LineSpacing) - LineSpacing + SectionInset.bottom;
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds), height);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributesList = [NSMutableArray new];

    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        // ensure we have the frame for the current page
        [self ensureLayoutAttributesForItemsUpTo:i];

        UICollectionViewLayoutAttributes *attributes = self.knownLayoutAttributes[i];
        CGRect itemFrame = attributes.frame;
        if (CGRectIntersectsRect(rect, itemFrame)) {
            [attributesList addObject:attributes];
        }
        if (CGRectGetMinY(itemFrame) > CGRectGetMaxY(rect)) {
            break;
        }
    }

    return attributesList;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    [self ensureLayoutAttributesForItemsUpTo:indexPath.item];
    return self.knownLayoutAttributes[indexPath.item];
}


#pragma mark - Invalidation

- (void)updateTruth {
    [self.knownLayoutAttributes removeAllObjects];
}

- (void)prepareLayout {
    [self updateTruth];
    [super prepareLayout];
}

- (void)invalidateLayoutWithContext:(UICollectionViewLayoutInvalidationContext *)context {
    NSMutableIndexSet *invalidatedItems = [NSMutableIndexSet new];
    for (NSIndexPath *indexPath in context.invalidatedItemIndexPaths) {
        [invalidatedItems addIndex:indexPath.item];
    }

    [super invalidateLayoutWithContext:context];
}

- (BOOL)shouldInvalidateLayoutForPreferredLayoutAttributes:(UICollectionViewLayoutAttributes *)preferredAttributes withOriginalAttributes:(UICollectionViewLayoutAttributes *)originalAttributes {
    // we don't support preferred attributes
    return NO;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGSizeEqualToSize(self.collectionView.bounds.size, newBounds.size);
}

- (UICollectionViewLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds {
    UICollectionViewLayoutInvalidationContext *context = [super invalidationContextForBoundsChange:newBounds];
    if (!CGSizeEqualToSize(self.collectionView.bounds.size, newBounds.size)) {
        NSArray<NSIndexPath *> *indexPaths = [self.knownLayoutAttributes valueForKeyPath:@"indexPath"];
        [context invalidateItemsAtIndexPaths:indexPaths];

        CGSize contentSizeChange = CGSizeMake(CGRectGetWidth(newBounds) - CGRectGetWidth(self.collectionView.bounds), 0.0);
        context.contentSizeAdjustment = contentSizeChange;
    }
    return context;
}


#pragma mark - Layout

- (void)ensureLayoutAttributesForItemsUpTo:(NSUInteger)toItem {
    const NSUInteger maxItemsCount = [self.collectionView numberOfItemsInSection:0];
    if (maxItemsCount == 0) {
        return;
    }

    toItem = MIN(toItem, maxItemsCount-1);

    NSMutableArray<UICollectionViewLayoutAttributes *> *cache = self.knownLayoutAttributes;
    if (cache.count > toItem) { // item already in cache. all good!
        return;
    }

    const CGRect bounds = self.collectionView.bounds;

    CGFloat width = (CGRectGetWidth(bounds) - SectionInset.left - SectionInset.right - 3 * InterItemSpacing) / 4.0;
    CGSize itemSize = CGSizeMake(width, ItemHeight);

    for (NSUInteger item = cache.count; item < maxItemsCount; item++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

        NSInteger column = item % 4;
        NSInteger row = item / 4;
        CGRect frame = CGRectMake(SectionInset.left + (InterItemSpacing + itemSize.width) * column, SectionInset.top + (LineSpacing + itemSize.height) * row, itemSize.width, itemSize.height);
        attributes.frame = frame;

        cache[item] = attributes;
    }
    
    NSParameterAssert(self.knownLayoutAttributes.count > toItem);
}


#pragma mark - Debugging

- (void)_printLayout {
    NSMutableString *string = [NSMutableString new];
    [self.knownLayoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendFormat:@"%tu: %@\n", idx, NSStringFromCGRect(obj.frame)];
    }];
    NSLog(@"################################\n############ LAYOUT ############\n################################\n%@################################", string);
}

@end
