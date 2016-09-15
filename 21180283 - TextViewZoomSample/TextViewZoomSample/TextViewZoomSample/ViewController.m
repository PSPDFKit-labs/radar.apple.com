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

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [[[UIAlertView alloc] initWithTitle:@"Instructions" message:@"1. Try scrolling the text (everything should be fine).\n2. Press zoom too set the zoom level to 2x.\n3. Try scrolling again (most of the time the external scroll view grabs the pan gesture)." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

#pragma mark - Actions

- (IBAction)tappedBackground:(id)sender {
    [self.textView endEditing:NO];
}

- (IBAction)zoomPressed:(id)sender {
    CGFloat scale = self.scrollView.zoomScale == 1.f ? 2.f : 1.f;
    [self.scrollView setZoomScale:scale animated:YES];
    [self.scrollView setContentOffset:CGPointMake(0.f, -self.scrollView.contentInset.top) animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.containerView;
}

@end
