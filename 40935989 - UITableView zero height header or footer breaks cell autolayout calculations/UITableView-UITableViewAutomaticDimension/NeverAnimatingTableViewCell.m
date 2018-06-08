//
//  NeverAnimatingTableViewCell.m
//  UITableView-UITableViewAutomaticDimension
//
//  Created by Marcin Krzyzanowski on 08/06/2018.
//  Copyright © 2018 Marcin Krzyzanowski. All rights reserved.
//

#import "NeverAnimatingTableViewCell.h"

@implementation NeverAnimatingTableViewCell
///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIView

- (void)didMoveToWindow {
    [super didMoveToWindow];
    [self contentSizeDidChange];
}

// Don't animate, ever.
- (void)layoutSubviews {
    [UIView performWithoutAnimation:^{
        [super layoutSubviews];
    }];
}

- (void)contentSizeDidChange {
    [self setNeedsLayout];
}
@end
