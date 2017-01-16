//
//  CollectionViewCell.m
//  CollectionViewLayout
//
//  Created by Michael Ochs on 1/12/17.
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];

        label.font = [UIFont systemFontOfSize:80.0];
        label.adjustsFontSizeToFitWidth = YES;

        self.label = label;
        self.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.5];
    }
    return self;
}

@end
