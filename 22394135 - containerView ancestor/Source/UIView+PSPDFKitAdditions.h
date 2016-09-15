#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (PSPDFKitAdditions)

/// The flattened subview tree, omitting the receiver.
@property (nonatomic, readonly) NSSet<__kindof UIView *> *pspdf_recursiveSubviews;

@end

NS_ASSUME_NONNULL_END
