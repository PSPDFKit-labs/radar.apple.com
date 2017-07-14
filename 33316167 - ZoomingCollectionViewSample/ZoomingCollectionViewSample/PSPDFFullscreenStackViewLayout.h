//
//  PSPDFStackViewLayout.h
//  ViewHierarchy
//
//  Created by Michael Ochs on 7/13/17.
//  Copyright © 2017 PSPDFKit GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSPDFFullscreenStackViewLayout : UICollectionViewLayout

@property (nonatomic) UIEdgeInsets margins;
@property (nonatomic) CGFloat interItemSpacing;
@property (nonatomic) CGSize itemSize;

@end

@interface PSPDFFullscreenStackViewLayout (Subclass)

- (UICollectionViewLayoutAttributes *)attributeForItem:(NSInteger)item;

@end
