//
//  ViewController.m
//  ZoomingCollectionViewSample
//
//  Created by Michael Ochs on 7/14/17.
//  Copyright © 2017 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"
#import "PSPDFFullscreenStackViewLayout.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) UIView *zoomView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PSPDFFullscreenStackViewLayout *layout = [PSPDFFullscreenStackViewLayout new];
    layout.interItemSpacing = 20.0;
    layout.margins = UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0);
    layout.itemSize = UIEdgeInsetsInsetRect(self.view.bounds, layout.margins).size;

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = UIColor.purpleColor;
    collectionView.scrollEnabled = NO;

    // FIXME: I'd love to not need to do that:
    collectionView.prefetchingEnabled = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = layout.collectionViewContentSize;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;

    UIView *zoomView = [[UIView alloc] initWithFrame:(CGRect){.size = scrollView.contentSize}];
    zoomView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [scrollView addSubview:zoomView];
    _zoomView = zoomView;

    [zoomView addSubview:collectionView];
    _collectionView = collectionView;

    // FIXME: I'd love for this to work:
    //[collectionView setShouldDeriveVisibleBoundsFromContainingScrollView:YES];

    scrollView.maximumZoomScale = 3.0;

    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    collectionView.frame = (CGRect){.size = layout.collectionViewContentSize};
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHue:indexPath.item/(CGFloat)[collectionView numberOfItemsInSection:indexPath.section] saturation:1.0 brightness:1.0 alpha:1.0];
    return cell;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        return self.zoomView;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        // FIXME: I'd love to not need to do that, as it breaks flow layout:
        CGRect bounds = [scrollView convertRect:scrollView.bounds toView:self.zoomView];
        self.collectionView.frame = bounds;
        self.collectionView.bounds = bounds;
    }
}

@end
