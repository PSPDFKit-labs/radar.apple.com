#import "DebugLayer.h"

static CGRect rectForSizeWithCenter(CGSize size, CGPoint center) {
    return CGRectMake(center.x - size.width / 2., center.y - size.height / 2., size.width, size.height);
}

@implementation DebugLayer

- (void)drawDebugInfoInContext:(CGContextRef)context forPath:(UIBezierPath *)path andPoints:(NSArray<NSValue*>*)points {
    CGContextSaveGState(context);

    __block CGPoint lastEndPoint = CGPointZero;
    __block CGPoint lastInkPoint = CGPointZero;

    void (^drawEndPoint)(CGPoint) = ^(CGPoint point) {
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, [UIColor.redColor colorWithAlphaComponent:0.75].CGColor);
        CGRect rect = rectForSizeWithCenter(CGSizeMake(12, 12), point);
        CGContextFillRect(context, rect);
        lastEndPoint = point;
        CGContextRestoreGState(context);
    };

    void (^drawControlPoint)(CGPoint) = ^(CGPoint point) {
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, [[UIColor redColor] colorWithAlphaComponent:0.75].CGColor);
        CGContextSetStrokeColorWithColor(context, [[UIColor redColor] colorWithAlphaComponent:0.75].CGColor);
        CGRect rect = rectForSizeWithCenter(CGSizeMake(6, 6), point);
        CGContextFillEllipseInRect(context, rect);
        CGContextSetLineWidth(context, 1);
        CGContextMoveToPoint(context, lastEndPoint.x, lastEndPoint.y);
        CGContextAddLineToPoint(context, point.x, point.y);
        CGContextDrawPath(context, kCGPathStroke);
        CGContextRestoreGState(context);
    };

    void (^drawInkPoint)(CGPoint) = ^(CGPoint point) {
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0 alpha:1.0].CGColor);
        CGRect rect = rectForSizeWithCenter(CGSizeMake(8, 8), point);
        CGContextFillRect(context, rect);
        if (!CGPointEqualToPoint(lastInkPoint, CGPointZero)) {
            CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor);
            CGFloat lengths[] = {10.0, 4.0};
            CGContextSetLineDash(context, 0, lengths, 2);
            CGContextSetLineWidth(context, 1);
            CGContextMoveToPoint(context, lastInkPoint.x, lastInkPoint.y);
            CGContextAddLineToPoint(context, point.x, point.y);
            CGContextDrawPath(context, kCGPathStroke);
        }
        lastInkPoint = point;
        CGContextRestoreGState(context);
    };

    void (^drawCurve)(CGPoint, CGPoint, CGPoint)  = ^(CGPoint endpoint, CGPoint control1, CGPoint control2) {
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, [UIColor.grayColor colorWithAlphaComponent:0.75].CGColor);
        CGContextSetStrokeColorWithColor(context, [UIColor.grayColor colorWithAlphaComponent:0.75].CGColor);
        CGContextSetLineWidth(context, 1);
        CGContextMoveToPoint(context, lastEndPoint.x, lastEndPoint.y);
        CGContextAddCurveToPoint(context, control1.x, control1.y, control2.x, control2.y, endpoint.x, endpoint.y);
        CGContextDrawPath(context, kCGPathStroke);
        CGContextRestoreGState(context);
    };

    CGPathApplyWithBlock(path.CGPath, ^(const CGPathElement *element) {
        CGPoint *points = element->points;
        CGPathElementType type = element->type;

        switch(type) {
            case kCGPathElementMoveToPoint:
                // Contains 1 point.
                drawEndPoint(points[0]);
                break;
            case kCGPathElementAddLineToPoint:
                // Contains 1 point.
                drawEndPoint(points[0]);
                break;
            case kCGPathElementAddQuadCurveToPoint: {
                // Contains 2 points.
                drawControlPoint(points[0]);
                drawEndPoint(points[1]);
            }
                break;
            case kCGPathElementAddCurveToPoint: {
                // Contains 3 points.
                drawCurve(points[2], points[0], points[1]);
                drawControlPoint(points[0]);
                drawEndPoint(points[2]);
                drawControlPoint(points[1]);
            }
                break;
            case kCGPathElementCloseSubpath:
                // Dos not contain any points.
                break;
        }
    });

    for (NSValue *point in points) {
        CGPoint actualPoint = point.CGPointValue;
        drawInkPoint(actualPoint);
    }

    CGContextRestoreGState(context);
}

- (void)drawInContext:(CGContextRef)ctx {
    __block CGContextRef ctxref = ctx;
    if (self.bezierPath != nil && self.points.count > 0) {
        [self drawDebugInfoInContext:ctxref forPath:self.bezierPath andPoints:self.points];
    }
}

@end
