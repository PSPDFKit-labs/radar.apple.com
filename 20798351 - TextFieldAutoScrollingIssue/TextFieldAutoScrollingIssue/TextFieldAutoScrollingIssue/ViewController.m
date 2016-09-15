#import "ViewController.h"

#define FIRST_RESPONDER_SCROLL_WORKAROUND_ENABLED 0

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Gesture recognizer

- (IBAction)didTap:(id)sender {
    [self.textField resignFirstResponder];
}

#pragma mark - Workaround

#if FIRST_RESPONDER_SCROLL_WORKAROUND_ENABLED

- (BOOL)_textFieldShouldScrollToVisibleWhenBecomingFirstResponder:(UITextField *)textField {
    // This is private API. It would be useful if it were made available publicly though.
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    UIScrollView *scrollView = [self closestScrollerOf:textField];
    if (!scrollView) return;
    // Scroll to the caret rect (if needed)
    CGRect caretRect = [textField caretRectForPosition:textField.selectedTextRange.start];
    // The cared is pretty thin so we slightly extend it, so we don't position it right on the edge of the viewport
    caretRect = CGRectInset(caretRect, -10.f, -10.f);
    // Don't scroll outside of the view, if the text overflows
    if (CGRectGetMaxX(caretRect) > CGRectGetMaxX(textField.bounds)) {
        caretRect.origin.x = CGRectGetMaxX(textField.bounds) - CGRectGetWidth(caretRect);
    }
    CGRect caretRectInScrollView = [textField convertRect:caretRect toView:scrollView];
    [scrollView scrollRectToVisible:caretRectInScrollView animated:YES];
}

- (UIScrollView *)closestScrollerOf:(UIView *)view {
    while ((view = view.superview)) {
        if ([view isKindOfClass:[UIScrollView class]]) return (UIScrollView *)view;
    }
    return nil;
}

#else

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"Workaround anybody?" message:@"That scrolling doesn't seem very useful in this case, does it? You can go to ViewController and enable FIRST_RESPONDER_SCROLL_WORKAROUND_ENABLED to see something that works a bit better." delegate:nil cancelButtonTitle:@"On it!" otherButtonTitles:nil] show];
        });
    });
}

#endif

@end
