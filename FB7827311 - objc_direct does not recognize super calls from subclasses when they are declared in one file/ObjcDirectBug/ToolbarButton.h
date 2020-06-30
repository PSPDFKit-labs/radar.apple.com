//
//  ToolbarButton.h
//  ObjcDirectBug
//
//  Created by Peter Steinberger on 30.06.20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define let const __auto_type
#define var __auto_type

static const CGFloat PSPDFDisabledButtonAlpha = 0.35;
static const CGFloat PSPDFHighlightedButtonAlpha = 0.5;

NS_ASSUME_NONNULL_BEGIN

// Uses the UIControlEventApplicationReserved range.
typedef NS_OPTIONS(NSUInteger, PSPDFToolbarButtonControlEvents) {
    /// Custom event for periodic button actions.
    PSPDFControlEventTick = 1 << 24,

    /**
     Similar to `UIControlEventTouchUpInside` but only sent if the button was
     not sending `PSPDFControlEventTick` events before the touch up.
     */
    PSPDFControlEventTouchUpInsideIfNotTicking = 1 << 25
};

@class PSPDFButton;

typedef void (^PSPDFButtonActionBlock)(PSPDFButton *button);

/// A collection of useful extensions to `UIButton`.
@interface PSPDFButton : UIButton

/**
 You can use this property to increase or decrease the hit area of a button. Use negative
 values to increase and positive values to decrease the touch area. Defaults to
 `UIEdgeInsetsZero`.
 */
@property (nonatomic) UIEdgeInsets touchAreaInsets;

/**
 Switch the default button image position.
 Defaults to NO (image on left).
 */
@property (nonatomic) BOOL positionImageOnRight;

/**
 A block that is called when a button action is performed.
 Setting this property uses UIControlEventTouchUpInside by default.
 */
@property (nonatomic, copy) PSPDFButtonActionBlock actionBlock;

/// Sets the `actionBlock` property to the provided block, registering for events specified by `controlEvents`.
- (void)setActionBlock:(nullable PSPDFButtonActionBlock)actionBlock forControlEvents:(UIControlEvents)controlEvents;

@end

// A UIButton subclass that mimic the appearance of plain style UIBarButtonItems.
@interface PSPDFToolbarButton : PSPDFButton

/// Sets the main button image. Sets it as the button image for several button states.
@property (nonatomic, nullable) UIImage *image;

/// When set the button will automatically switch to the small image if its height is less or equal to 32pt.
@property (nonatomic, nullable) UIImage *smallSizeImage;

/// Toggles the appearance between the highlighted and normal state.
- (void)styleForHighlightedState:(BOOL)highlighted;

/// General purpose user data storage.
@property (nonatomic, nullable) id userInfo;

/// Allows animated transitions between the enabled and disabled appearance.
- (void)setEnabled:(BOOL)enabled animated:(BOOL)animated;

#pragma mark Metrics

/**
 Designates the button to be collapsible into one item, if toolbar space is limited.
 Defaults to YES.
 */
@property (nonatomic, getter=isCollapsible) BOOL collapsible;

/**
 The fixed length value. Will become the button width or height depending on the toolbar orientation.
 Set to -1. to use the default toolbar length (the default).
 */
@property (nonatomic) CGFloat length;

/// Automatically sets the length to the intrinsic size width.
- (void)setLengthToFit;

/**
 If YES, the actual button space will be computed dynamically by counting all button instances
 and dividing the remaining available toolbar space with that number. Otherwise the length will be
 taken from the `length` property. Defaults to NO.
 */
@property (nonatomic, getter=isFlexible) BOOL flexible;

#pragma mark Appearance

/**
 Called whenever the tint color changes. Use to update tint color dependent
 content (like a tint color based custom drawn image or attributed text).
 */
@property (nonatomic, copy, nullable) void (^tintColorDidChangeBlock)(UIColor *tintColor);

@end

/// Sends out `PSPDFControlEventTick` events while the button is pressed.
@interface PSPDFToolbarTickerButton : PSPDFToolbarButton

/// The time interval between subsequent tick events.
@property (nonatomic) NSTimeInterval timeInterval;

/// If set, gradually decreases the time interval between subsequent ticks. Defaults to YES.
@property (nonatomic) BOOL accelerate;

@end

NS_ASSUME_NONNULL_END
