#import "ViewController.h"
#import "DebugLayer.h"

static NSValue* xy(CGFloat x, CGFloat y) {
    return [NSValue valueWithCGPoint:CGPointMake(x, y)];
}

static CGFloat distance(CGPoint a, CGPoint b) {
    return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2));
}

@interface ViewController ()

@property NSUInteger currentlyPannedPointIndex;
@property NSUInteger bugIndex;
@property (nonatomic, retain) NSMutableArray<NSValue*>* points;

@property (nonatomic, retain) CAShapeLayer *shapeLayer;
@property (nonatomic, retain) DebugLayer *debugLayer;

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *pan;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.currentlyPannedPointIndex = 0;
    self.bugIndex = 0;

    self.points = [NSMutableArray arrayWithArray:@[
        xy(200, 200),
        xy(200, 500),
        xy(700, 400),
        xy(400, 900)
    ]];

    self.shapeLayer = [CAShapeLayer layer];
    [self.view.layer addSublayer:self.shapeLayer];

    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.2].CGColor;
    self.shapeLayer.lineWidth = 100;
    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.lineJoin = kCALineJoinRound;

    self.debugLayer = [DebugLayer layer];
    [self.view.layer addSublayer:self.debugLayer];
}

- (void)viewWillLayoutSubviews {
    self.shapeLayer.frame = self.view.bounds;
    self.debugLayer.frame = self.view.bounds;
    [self updateBezierPath];
}

- (IBAction)cycleBuggyConfig:(id)sender {
    if (self.bugIndex % 4 == 0) {
        self.points = [NSMutableArray arrayWithArray:@[
            xy(93, 181),
            xy(187.5, 469.5),
            xy(306.5, 248),
            xy(409, 216)
        ]];
    } else if (self.bugIndex % 4 == 1) {
        self.points = [NSMutableArray arrayWithArray:@[
            xy(79.5, 188.5),
            xy(443.5, 478),
            xy(277.5, 189),
            xy(91, 380.5)
        ]];
    } else if (self.bugIndex % 4 == 2) {
        self.points = [NSMutableArray arrayWithArray:@[
            xy(99, 227.5),
            xy(134.5, 528),
            xy(453, 443.5),
            xy(121.5, 531.5)
        ]];
    } else if (self.bugIndex % 4 == 3) {
        self.points = [NSMutableArray arrayWithArray:@[
            xy(144.5, 243),
            xy(134.5, 528),
            xy(453, 443.5),
            xy(134, 527)
        ]];
    }
    self.bugIndex += 1;
    [self updateBezierPath];
}

- (void)updateBezierPath {
    UIBezierPath *bezierPath = PSPDFBezierSplineFromPoints(self.points);

    self.shapeLayer.path = bezierPath.CGPath;
    self.debugLayer.bezierPath = bezierPath;
    self.debugLayer.points = self.points;

    [self.shapeLayer setNeedsDisplay];
    [self.debugLayer setNeedsDisplay];
}

- (IBAction)panned:(UIPanGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.view];

    if (sender.state == UIGestureRecognizerStateBegan) {
        CGFloat min = DBL_MAX;
        for (int i=0; i<self.points.count; i++) {
            CGFloat d = distance(location, self.points[i].CGPointValue);
            min = fmin(d, min);
            if (d == min) { self.currentlyPannedPointIndex = i; }
        }
    } else {
        [self.points replaceObjectAtIndex:self.currentlyPannedPointIndex withObject:xy(location.x, location.y)];
    }
    [self updateBezierPath];
}

static UIBezierPath *PSPDFBezierSplineFromPoints(NSArray<NSValue *> *points) {
    // Bezier B-spline curves (Figure 11)
    // @see http://www.math.ucla.edu/~baker/149.1.02w/handouts/dd_splines.pdf

    UIBezierPath *path = [UIBezierPath new];
    NSUInteger count = [points count];

    // Return an empty path if there are no points.
    if (count == 0) {
        return path;
    }

    // We always start at point 0
    [path moveToPoint:points[0].CGPointValue];

    if (count == 1) {
        // Make a short line (dot), if there's just one point
        [path addLineToPoint:CGPointMake(points[0].CGPointValue.x + 0.001, points[0].CGPointValue.y + 0.001)];
    } else if (count == 2) {
        // Straight line with just two point. We also do this if we're not drawing a spline.
        [path moveToPoint:points[0].CGPointValue];
        for (NSUInteger idx = 1; idx < count; ++idx) {
            [path addLineToPoint:points[idx].CGPointValue];
        }
    } else {
        // Bezier spline
        for (NSUInteger idx = 2; idx < count; ++idx) {
            // Last 3 points from the list.
            CGPoint p0 = points[idx - 2].CGPointValue;
            CGPoint p1 = points[idx - 1].CGPointValue;
            CGPoint p2 = points[idx].CGPointValue;

            // Calculate control points between p0 and p1 such that they are at 1/4 and 3/4 distance on the line segment.
            CGPoint cp0 = CGPointMake((2.0 * p0.x + p1.x) / 3.0, (2.0 * p0.y + p1.y) / 3.0);
            CGPoint cp1 = CGPointMake(2.0 * cp0.x - p0.x, 2.0 * cp0.y - p0.y);

            // We also need the first control point of the upcoming spline, which at 1/4 distance between p1 and p2.
            CGPoint cp2 = CGPointMake((2.0 * p1.x + p2.x) / 3.0, (2.0 * p1.y + p2.y) / 3.0);

            // Compute the distance to the mid point between cp1 and cp2.
            CGPoint midPoint = CGPointMake((cp1.x + cp2.x) / 2.0, (cp1.y + cp2.y) / 2.0);

            [path addCurveToPoint:midPoint controlPoint1:cp0 controlPoint2:cp1];

            if (idx == count - 1) {
                // This is the second control point of the last spline, which at 3/4 distance between p1 and p2.
                CGPoint cp3 = CGPointMake(2.0 * cp2.x - p1.x, 2.0 * cp2.y - p1.y);
                [path addCurveToPoint:p2 controlPoint1:cp2 controlPoint2:cp3];
            }
        }
    }

    return path;
}

@end
