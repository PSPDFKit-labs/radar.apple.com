#import "FormPageTwoView.h"

@implementation FormPageTwoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self == nil) return nil;

    [self setBackgroundColor:[UIColor whiteColor]];

    _decoration = [[UIView alloc] init];
    [_decoration setBackgroundColor:[UIColor darkGrayColor]];
    [[_decoration layer] setCornerRadius:10];

    _textField = [[UITextField alloc] init];
    _textField.placeholder = @"This is a text field";

    for (UIView *subview in @[_decoration, _textField]) {
        [self addSubview:subview];
        [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    }

    [self addConstraints:@[
        [NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:_decoration attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_textField attribute:NSLayoutAttributeWidth multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:_decoration attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_textField attribute:NSLayoutAttributeHeight multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:_decoration attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_textField attribute:NSLayoutAttributeTop multiplier:1 constant:-20],
        [NSLayoutConstraint constraintWithItem:_decoration attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_textField attribute:NSLayoutAttributeLeading multiplier:1 constant:0],
    ]];

    return self;
}

@end
