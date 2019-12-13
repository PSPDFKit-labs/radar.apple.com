#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DebugLayer : CALayer

@property (nonatomic, retain) UIBezierPath* bezierPath;
@property (nonatomic, retain) NSArray<NSValue*>* points;

@end

NS_ASSUME_NONNULL_END
