#import "CustomCell.h"

#define let __auto_type const

#define USE_CONSTRAINTS 1

@implementation CustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self == nil) return nil;

    _customLabel = [[UILabel alloc] init];
    _customLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _customLabel.adjustsFontForContentSizeCategory = YES;
    _customLabel.numberOfLines = 0;
    [self.contentView addSubview:_customLabel];

#if USE_CONSTRAINTS
    _customLabel.translatesAutoresizingMaskIntoConstraints = NO;
    let container = self.layoutMarginsGuide;
    [NSLayoutConstraint activateConstraints:@[
        [_customLabel.leadingAnchor constraintEqualToAnchor:container.leadingAnchor],
        [container.trailingAnchor constraintEqualToAnchor:_customLabel.trailingAnchor],
        [_customLabel.topAnchor constraintEqualToAnchor:container.topAnchor],
        [container.bottomAnchor constraintEqualToAnchor:_customLabel.bottomAnchor],
    ]];
#endif

    return self;
}

#if !USE_CONSTRAINTS
- (CGSize)sizeThatFits:(CGSize)size {
    let availableWidth = size.width - self.layoutMargins.left - self.layoutMargins.right;
    let height = self.layoutMargins.top + [self.customLabel sizeThatFits:CGSizeMake(availableWidth, CGFLOAT_MAX)].height + self.layoutMargins.bottom;
    return CGSizeMake(size.width, MAX(height, 44));
}

- (void)layoutSubviews {
    [super layoutSubviews];

    let customLabelFrameInCell = UIEdgeInsetsInsetRect(self.bounds, self.layoutMargins);
    self.customLabel.frame = [self.contentView convertRect:customLabelFrameInCell fromView:self];
}
#endif

@end
