//
//  ToolbarButton.m
//  ObjcDirectBug
//
//  Created by Peter Steinberger on 30.06.20.
//

#import "ToolbarButton.h"

// https://pspdfkit.com/blog/2020/improving-performance-via-objc-direct/
// https://nshipster.com/direct/
// Direct method and property calls increases performance and reduces binary size.
// Checking if the attribute is supported doesn't work, Xcode 11 supports it but gives a compile time error.
// Setting DISABLE_OBJC_DIRECT in the build settings will disable this feature.
#if defined(__IPHONE_14_0) || defined(__MAC_10_16) || defined(__TVOS_14_0) || defined(__WATCHOS_7_0)
#define PSPDF_OBJC_DIRECT_MEMBERS __attribute__((objc_direct_members))
#define PSPDF_OBJC_DIRECT __attribute__((objc_direct))
#define PSPDF_DIRECT ,direct
#else
#define PSPDF_OBJC_DIRECT_MEMBERS
#define PSPDF_OBJC_DIRECT
#define PSPDF_DIRECT
#endif


@interface PSPDFButton ()
@property (nonatomic) UIControlEvents registeredControlEvents;
@end

@implementation PSPDFButton

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self commonInit];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _touchAreaInsets = UIEdgeInsetsZero;
}

#pragma mark - Layout

- (void)setPositionImageOnRight:(BOOL)positionImageOnRight {
    self.semanticContentAttribute = positionImageOnRight ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight;
    if (_positionImageOnRight != positionImageOnRight) {
        _positionImageOnRight = positionImageOnRight;
        [self setNeedsLayout];
    }
}

#pragma mark - Touch handling

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.touchAreaInsets, UIEdgeInsetsZero) || !self.enabled || !self.userInteractionEnabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }

    CGRect relativeTouchFrame = UIEdgeInsetsInsetRect(self.bounds, self.touchAreaInsets);
    return CGRectContainsPoint(relativeTouchFrame, point);
}

#pragma mark - Actions

- (void)setActionBlock:(PSPDFButtonActionBlock)actionBlock {
    [self setActionBlock:actionBlock forControlEvents:UIControlEventTouchUpInside];
}

- (void)setActionBlock:(PSPDFButtonActionBlock)actionBlock forControlEvents:(UIControlEvents)controlEvents {
    if (_actionBlock) {
        // Make sure we no longer get any messages for the previous control events
        [self removeTarget:self action:@selector(performBlockAction:) forControlEvents:self.registeredControlEvents];
    }
    _actionBlock = actionBlock;
    if (actionBlock) {
        self.registeredControlEvents = controlEvents;
        [self addTarget:self action:@selector(performBlockAction:) forControlEvents:controlEvents];
    }
}

- (void)performBlockAction:(PSPDFButton *)sender {
    self.actionBlock(sender);
}

@end




@implementation PSPDFToolbarButton

#pragma mark - Lifecycle

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Default text color
        [self setTitleColor:self.tintColor forState:UIControlStateNormal];
        // Match UIToolbar highlight behavior
        [self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [self addTarget:self action:@selector(touchExit) forControlEvents:UIControlEventTouchDragExit];
        [self addTarget:self action:@selector(touchEnter) forControlEvents:UIControlEventTouchDragEnter];
        self.showsTouchWhenHighlighted = NO;
        _collapsible = YES;
        _length = -1.0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // We need to re-apply alpha values at this point
    [self styleForHighlightedState:self.highlighted];
    [self updateImageIfNeeded];
}

#pragma mark - State

- (void)setEnabled:(BOOL)enabled {
    [self setEnabled:enabled animated:NO];
}

- (void)setEnabled:(BOOL)enabled animated:(BOOL)animated {
    super.enabled = enabled;
    [self styleForHighlightedState:self.highlighted animated:animated];
}

#pragma mark - Image

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        [self updateImageIfNeeded];
    }
}

- (void)setSmallSizeImage:(UIImage *)smallSizeImage {
    if (_smallSizeImage != smallSizeImage) {
        _smallSizeImage = smallSizeImage;
        [self updateImageIfNeeded];
    }
}

- (UIImage *)imageForCurrentSize {
    let image = self.image;
    let smallSizeImage = self.smallSizeImage;
    if (!smallSizeImage) { return image; }
    return CGRectGetHeight(self.bounds) <= 32 ? smallSizeImage : image;
}

- (void)updateImageIfNeeded {
    let image = self.imageForCurrentSize;
    if (!image || image == [self imageForState:UIControlStateNormal]) { return; }

    [self setImage:image forState:UIControlStateNormal];
    // Avoid the default gray tint adjustment in highlighted and disabled state
    // since we're adjusting the opacity ourselves (produces nicer animations)
    [self setImage:image forState:UIControlStateHighlighted];
    [self setImage:image forState:UIControlStateDisabled];
}

#pragma mark - Metrics

- (void)setLengthToFit {
    CGSize fittingSize = self.intrinsicContentSize;
    if (fittingSize.width == UIViewNoIntrinsicMetric) {
        self.length = -1.0;
    } else {
        self.length = ceil(fittingSize.width);
    }
}

#pragma mark - Touch handling

- (void)touchDown {
    [self styleForHighlightedState:YES animated:NO];
}

- (void)touchUp {
    [self styleForHighlightedState:NO animated:YES];
}

- (void)touchExit {
    [self styleForHighlightedState:NO animated:YES];
}

- (void)touchEnter {
    [self styleForHighlightedState:YES animated:YES];
}

#pragma mark - Highlight

- (void)styleForHighlightedState:(BOOL)highlighted animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self styleForHighlightedState:highlighted];
        }];
    } else {
        [self styleForHighlightedState:highlighted];
    }
}

- (void)styleForHighlightedState:(BOOL)highlighted {
    CGFloat alpha = highlighted ? PSPDFHighlightedButtonAlpha : 1.0;
    if (!self.enabled) {
        alpha = PSPDFDisabledButtonAlpha;
    }
    self.imageView.alpha = alpha;
    self.titleLabel.alpha = alpha;
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    // Always match the title color to the tint color, mimicking the system button style behavior
    UIColor *tintColor = self.tintColor;
    [self setTitleColor:tintColor forState:UIControlStateNormal];
    if (self.tintColorDidChangeBlock) {
        self.tintColorDidChangeBlock(tintColor);
    }
}

@end



@interface PSPDFToolbarTickerButton ()
@property (nonatomic) BOOL timerFired;
@property (nonatomic, retain) NSTimer *timer;
- (void)timerFired:(NSTimer *)timer;
@end

PSPDF_OBJC_DIRECT_MEMBERS
@implementation PSPDFToolbarTickerButton

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        _timeInterval = 0.2;
        _accelerate = YES;
    }
    return self;
}

#pragma mark - Touch handling

- (void)touchDown {
    [super touchDown];
    self.timerFired = NO;
    // If tapping really quickly we can get a touchDown before
    // touchUp for the previous tap is sent.
    [self.timer invalidate];
    self.timer = [self scheduleTimerBasedOnTimer:nil];
}

- (void)touchUp {
    [super touchUp];
    [self.timer invalidate];
    self.timer = nil;
    if (!self.timerFired) {
        [self sendActionsForControlEvents:(UIControlEvents)(PSPDFControlEventTouchUpInsideIfNotTicking)];
    }
    self.timerFired = NO;
}

#pragma mark - Timer

- (NSTimer *)scheduleTimerBasedOnTimer:(NSTimer *)previousTimer {
    NSTimeInterval interval = self.timeInterval;
    NSUInteger fireCount = 0;
    if (previousTimer) {
        if (self.accelerate) {
            fireCount = [previousTimer.userInfo unsignedIntegerValue];
            NSUInteger maxFixeCount = 50;
            NSTimeInterval maxDecrease = 4.0;
            fireCount = MIN(fireCount, maxFixeCount);
            double percentage = (double)fireCount / (double)maxFixeCount;
            interval = interval / ((percentage * (maxDecrease - 1.0)) + 1.0);
        }
        [previousTimer invalidate];
    }

    return [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerFired:) userInfo:@(fireCount + 1) repeats:NO];
}

- (void)timerFired:(NSTimer *)timer {
    if (!self.enabled) {
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    self.timerFired = YES;
    [self sendActionsForControlEvents:(UIControlEvents)PSPDFControlEventTick];
    self.timer = [self scheduleTimerBasedOnTimer:timer];
}

@end
