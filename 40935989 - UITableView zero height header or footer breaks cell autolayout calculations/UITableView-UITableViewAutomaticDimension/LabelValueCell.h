//
//  LabelValueCell.h
//  UITableView-UITableViewAutomaticDimension
//
//  Created by Marcin Krzyzanowski on 08/06/2018.
//  Copyright © 2018 Marcin Krzyzanowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NeverAnimatingTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LabelValueCell : NeverAnimatingTableViewCell

@property (nonatomic, readonly, nullable) UIImageView *imageView NS_UNAVAILABLE;
@property (nonatomic, readonly, nullable) UILabel *textLabel NS_UNAVAILABLE;
@property (nonatomic, readonly, nullable) UILabel *detailTextLabel NS_UNAVAILABLE;

@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UILabel *valueLabel;

@end

NS_ASSUME_NONNULL_END
