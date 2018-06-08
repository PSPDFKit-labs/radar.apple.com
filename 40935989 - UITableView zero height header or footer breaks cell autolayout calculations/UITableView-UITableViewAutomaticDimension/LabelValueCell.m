//
//  LabelValueCell.m
//  UITableView-UITableViewAutomaticDimension
//
//  Created by Marcin Krzyzanowski on 08/06/2018.
//  Copyright © 2018 Marcin Krzyzanowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelValueCell.h"

#define let const __auto_type

@implementation LabelValueCell

// silence warning for unavailable properties:
@dynamic imageView, textLabel, detailTextLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.preservesSuperviewLayoutMargins = YES;

        let titleLabel = [UILabel new];
        titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        titleLabel.textColor = UIColor.grayColor;
        [titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _titleLabel = titleLabel;

        let valueLabel = [UILabel new];
        valueLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        valueLabel.textAlignment = NSTextAlignmentRight;
        valueLabel.numberOfLines = 0;
        valueLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [valueLabel setContentHuggingPriority:(UILayoutPriorityDefaultLow - 1) forAxis:UILayoutConstraintAxisHorizontal];
        [valueLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
        [valueLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [valueLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _valueLabel = valueLabel;

        let contentView = self.contentView;
        contentView.preservesSuperviewLayoutMargins = YES;

        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [contentView addSubview:titleLabel];

        valueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [contentView addSubview:valueLabel];

        [NSLayoutConstraint activateConstraints:@[
              [contentView.layoutMarginsGuide.topAnchor constraintEqualToAnchor:titleLabel.topAnchor],
              [contentView.layoutMarginsGuide.leadingAnchor constraintEqualToAnchor:titleLabel.leadingAnchor],
              [contentView.layoutMarginsGuide.bottomAnchor constraintEqualToAnchor:titleLabel.bottomAnchor],

              [titleLabel.trailingAnchor constraintEqualToAnchor:valueLabel.leadingAnchor constant:-8.f],

              [valueLabel.topAnchor constraintEqualToAnchor:contentView.layoutMarginsGuide.topAnchor],
              [valueLabel.trailingAnchor constraintEqualToAnchor:contentView.layoutMarginsGuide.trailingAnchor],
              [valueLabel.bottomAnchor constraintEqualToAnchor:contentView.layoutMarginsGuide.bottomAnchor]
      ]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.preferredMaxLayoutWidth = self.titleLabel.frame.size.width - self.titleLabel.layoutMargins.left - self.titleLabel.layoutMargins.right;
    self.valueLabel.preferredMaxLayoutWidth = self.valueLabel.frame.size.width - self.valueLabel.layoutMargins.left - self.valueLabel.layoutMargins.right;;
    NSLog(@"titleLabel.preferredMaxLayoutWidth %@", @(self.titleLabel.preferredMaxLayoutWidth));
    NSLog(@"valueLabel.preferredMaxLayoutWidth %@", @(self.valueLabel.preferredMaxLayoutWidth));
    [super layoutSubviews];
}

@end
