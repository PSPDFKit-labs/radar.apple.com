//
//  ViewController.m
//  ScrollViewCenteringExample
//
//  Created by Matej Bukovinski on 26. 10. 15.
//  Copyright © 2015 PSPDFKit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat pageSizeDelta = 15.f;

    CGRect availableFrame = [UIScreen mainScreen].bounds;
    CGRect frame = CGRectMake(0.f, 0.f, CGRectGetWidth(availableFrame) - pageSizeDelta, CGRectGetHeight(availableFrame));
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    contentView.backgroundColor = [UIColor redColor];

    UIScrollView *scrollView = self.scrollView;
    [scrollView addSubview:contentView];
    scrollView.contentSize = frame.size;

    scrollView.contentInset = UIEdgeInsetsMake(0.f, pageSizeDelta / 2.f, 0.f, pageSizeDelta / 2.f);
    scrollView.contentOffset = CGPointMake(- (pageSizeDelta / 2.f), 0.f);
}

@end

@implementation DebugScrollView

- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];
    NSLog(@"Set: %@, Applied: %@", NSStringFromCGPoint(contentOffset), NSStringFromCGPoint(self.contentOffset));
}

@end
