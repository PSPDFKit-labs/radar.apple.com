//
//  ViewController.m
//  ScrollViewTouchForwarding
//
//  Created by Michael Ochs on 8/11/17.
//  Copyright © 2017 Michael Ochs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, readonly) UIScrollView *outerScrollView;
@property (nonatomic, readonly) UIScrollView *intermediateScrollView;
@property (nonatomic, readonly) NSArray<UIScrollView *> *innerScrollViews;
@property (nonatomic, readonly) NSArray<UIView *> *innerZoomViews;

@end

#define let const __auto_type

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    let pages = 10;

    let outerScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    outerScrollView.pagingEnabled = YES;
    outerScrollView.contentSize = CGSizeMake(CGRectGetWidth(outerScrollView.bounds) * pages, CGRectGetHeight(outerScrollView.bounds));
    [self.view addSubview:outerScrollView];
    _outerScrollView = outerScrollView;

    let intermediateScrollView = [[UIScrollView alloc] initWithFrame:(CGRect){.size = outerScrollView.contentSize}];
    intermediateScrollView.contentSize = intermediateScrollView.bounds.size;
    intermediateScrollView.scrollEnabled = NO;
    [outerScrollView addSubview:intermediateScrollView];
    _intermediateScrollView = intermediateScrollView;

    let innerScrollViews = [NSMutableArray<UIScrollView *> new];
    let innerZoomViews = [NSMutableArray<UIView *> new];
    for (NSInteger page = 0; page < pages; page++) {
        let frame = (CGRect){.origin = {.x = page * CGRectGetWidth(outerScrollView.bounds), .y = 0.0}, .size = outerScrollView.bounds.size};
        let scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.delegate = self;
        scrollView.contentSize = scrollView.bounds.size;
        scrollView.maximumZoomScale = 3.0;
        [intermediateScrollView addSubview:scrollView];
        [innerScrollViews addObject:scrollView];

        let zoomView = [[UIView alloc] initWithFrame:scrollView.bounds];
        zoomView.layer.borderColor = UIColor.redColor.CGColor;
        zoomView.layer.borderWidth = 1.0;
        [scrollView addSubview:zoomView];
        [innerZoomViews addObject:zoomView];

        let label = [[UILabel alloc] initWithFrame:zoomView.bounds];
        label.font = [UIFont systemFontOfSize:100.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @(page).stringValue;
        [zoomView addSubview:label];
    }

    _innerScrollViews = innerScrollViews.copy;
    _innerZoomViews = innerZoomViews.copy;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    NSInteger index = [self.innerScrollViews indexOfObject:scrollView];
    if (index == NSNotFound) { return nil; }
    return self.innerZoomViews[index];
}

@end
