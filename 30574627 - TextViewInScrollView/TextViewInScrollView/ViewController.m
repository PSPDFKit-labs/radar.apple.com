//
//  ViewController.m
//  TextViewInScrollView
//
//  Created by Michael Ochs on 2/17/17.
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) IBOutlet UIView *zoomView;
@property (nonatomic) IBOutlet UITextView *textView;

@end


@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // zoom to have the content view be the full width
    CGFloat zoomScale = CGRectGetWidth(self.scrollView.bounds) / CGRectGetWidth(self.zoomView.bounds);
    [self.scrollView setZoomScale:zoomScale animated:YES];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.zoomView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self updateZoomScale:scrollView.zoomScale];
}

- (void)updateZoomScale:(CGFloat)zoomScale {
    // in order to render the font crystal clear we need to update the content scale of the text view's subviews

    CGFloat contentScale = zoomScale * UIScreen.mainScreen.scale;

    for (UIView *subview in self.textView.subviews) {
        subview.contentScaleFactor = contentScale;
    }
}

@end
