//
//  ViewController.m
//  CollectionViewGridLayout
//
//  Created by Peter Steinberger on 05/05/15.
//  Copyright (c) 2015 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"democell"];

    const CGFloat borderWidth = 20.f;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    flowLayout.minimumLineSpacing = borderWidth;
    flowLayout.minimumInteritemSpacing = borderWidth*2;
    flowLayout.sectionInset = UIEdgeInsetsMake(borderWidth, borderWidth, borderWidth, borderWidth);

    // HACK HACK HACK - workaroumd to change last line justifyment.
//    NSMutableDictionary *rowAlignmentOptions = [NSMutableDictionary dictionaryWithDictionary:[flowLayout valueForKey:@"rowAlignmentOptions"]];
//    rowAlignmentOptions[@"UIFlowLayoutLastRowHorizontalAlignmentKey"] = rowAlignmentOptions[@"UIFlowLayoutCommonRowHorizontalAlignmentKey"];
//    [flowLayout setValue:rowAlignmentOptions forKey:@"rowAlignmentsOptions"];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"democell" forIndexPath:indexPath];

    // pretty color is pretty
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    cell.backgroundColor = color;

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    // fit two items
    const NSUInteger itemsPerLine = 2;
    const CGFloat width = floor(self.view.bounds.size.width/itemsPerLine - ((UICollectionViewFlowLayout *)collectionViewLayout).minimumInteritemSpacing);

    // Remove the "arc4random() % 2" part to have a justified last line.
    return CGSizeMake(width-35, width-arc4random() % 2);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

@end
