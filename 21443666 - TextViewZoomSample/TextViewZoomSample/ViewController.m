//
//  ViewController.m
//  TextViewZoomSample
//
//  Created by Matej Bukovinski on 12. 05. 15.
//  Copyright (c) 2015 PSPDFKit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UISwitch *recursiveSwitch;
@end

@implementation ViewController

#pragma mark - Scale

- (void)updateForZoomScale:(CGFloat)zoomScale {
    // We apply the contentScaleFactor in after every zoom level change
    CGFloat screenAndZoomScale = zoomScale * [UIScreen mainScreen].scale;
    self.textView.zoomScale = screenAndZoomScale;
    self.textView.layer.contentsScale = screenAndZoomScale;

    if (self.recursiveSwitch.on) {
        // Walk the layer and view hierarchies separately. We need to reach all tiled layers.
        [self applyScale:(zoomScale * [UIScreen mainScreen].scale) toView:self.textView];
        [self applyScale:(zoomScale * [UIScreen mainScreen].scale) toLayer:self.textView.layer];
    }
}

#pragma mark - Actions

- (IBAction)tappedBackground:(id)sender {
    [self.textView endEditing:NO];
}

- (IBAction)recursiveSwitchValueChanged:(UISwitch *)sender {
    [self updateForZoomScale:self.scrollView.zoomScale];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    [self updateForZoomScale:scale];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.containerView;
}

#pragma mark - Helpers

- (void)applyScale:(CGFloat)scale toView:(UIView *)view {
    view.contentScaleFactor = scale;
    view.layer.contentsScale = scale;
    for (UIView *subview in view.subviews) {
        [self applyScale:scale toView:subview];
    }
}

- (void)applyScale:(CGFloat)scale toLayer:(CALayer *)layer {
    layer.contentsScale = scale;
    for (CALayer *sublayer in layer.sublayers) {
        [self applyScale:scale toLayer:sublayer];
    }
}

@end
