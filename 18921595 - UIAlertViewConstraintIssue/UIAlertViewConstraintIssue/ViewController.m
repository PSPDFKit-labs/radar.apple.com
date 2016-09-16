#import "ViewController.h"

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self greetings];
}

- (void)greetings {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Constraint Issue" message:@"Tap Present to show the action sheet... however it will not show up because of unsatisfyable constraints. We set the whole controller rect as sourceRect, and UIKit isn't smart enough to center it in that case. All you'll see is the dimming view." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"\"Present\"" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self presentOrNotPresentThatIsTheQuestion];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Nope..." style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Sorry, not letting you out!");
        [self greetings];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)presentOrNotPresentThatIsTheQuestion {
    UIAlertController *sheetController = [UIAlertController alertControllerWithTitle:@"Constraint Issue" message:@"Will never show up" preferredStyle:UIAlertControllerStyleActionSheet];
    [sheetController addAction:[UIAlertAction actionWithTitle:@"Nope" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Never be tapped...");
    }]];
    [sheetController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    UIPopoverPresentationController *popoverPresentation = sheetController.popoverPresentationController;
    if (popoverPresentation) { // nil on iPhone
        popoverPresentation.sourceView = self.view;
        popoverPresentation.sourceRect = self.view.bounds;
        //        popoverPresentation.sourceRect = (CGRect){.origin=self.view.center, .size=CGSizeMake(1.f, 1.f)};
    }
    [self presentViewController:sheetController animated:YES completion:nil];
}

@end
