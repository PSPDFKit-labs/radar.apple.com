//
//  ViewController.m
//  AutocorrectResizeSample
//
//  Created by Matej Bukovinski on 8. 01. 15.
//  Copyright (c) 2015 PSPDFKit. All rights reserved.
//

#import "ViewController.h"

// Set to 1 to see a potential workaround in action
#define AUTOCORRECT_SELECTION_WORKAROUND_ENABLED 1

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect bounds = self.view.bounds;
    // Make sre we ca scroll the outer scroll view
    self.scrollView.contentSize = CGSizeMake(bounds.size.width, bounds.size.height * 2.f);
}

- (IBAction)resizeTextButtonPressed:(id)sender {
    // Toggle font size between 14 and 24 pt
    BOOL large = self.textView.font.pointSize == 24.f;
    self.textView.font = [UIFont systemFontOfSize:large ? 14.f : 24.f];
#if AUTOCORRECT_SELECTION_WORKAROUND_ENABLED
    [self.textView.inputDelegate textWillChange:self.textView];
    [self.textView.inputDelegate textDidChange:self.textView];
#endif
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
#if AUTOCORRECT_SELECTION_WORKAROUND_ENABLED
    [self.textView.inputDelegate textWillChange:self.textView];
    [self.textView.inputDelegate textDidChange:self.textView];
#endif
}

@end
