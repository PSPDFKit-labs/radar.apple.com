//
//  ViewController.m
//  PopoverPresentationControllerMultipleDismissal
//
//  Created by Peter Steinberger on 22/11/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPopoverPresentationControllerDelegate>
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        // Present yellow modal view
        UIViewController *controller = [UIViewController new];
        controller.view.backgroundColor = [UIColor yellowColor];

        [self presentViewController:controller animated:YES completion:^{

            // Show the red popover
            UIViewController *popover = [UIViewController new];
            popover.view.backgroundColor = [UIColor redColor];
            popover.modalPresentationStyle = UIModalPresentationPopover;
            popover.popoverPresentationController.sourceView = self.view;
            popover.popoverPresentationController.sourceRect = CGRectMake(200.f, 200.f, 1.f, 1.f);

#warning Enable this to "fix" the problem.
            //popover.popoverPresentationController.delegate = self;

            [controller presentViewController:popover animated:YES completion:^{

                // Show an alert to explain the radar
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Radar" message:@"A tap on the yellow area (dimming view) will dismiss the popover, however a double tap will invoke the internal dismissal logic twice, and then also dismissing the yellow modal view, which it really, really shouldn't.\n\nIf we manually define a delegate for the popoverPresentationController, UIKit's dimmingViewWasTapped: runs a different code path and checks for dismissing before calling dismiss, which fixes the issue." preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:NULL]];
                [popover presentViewController:alert animated:YES completion:NULL];
            }];
        }];
    });
}

// This is really really strange. Simply implementing this and returning YES is enough to "fix" the issue.
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    return YES;
}


// PSEUDOCODE FOR THE BUG IN UIKit:
// If the delegate is implemented, it runs a different code path that checks if popover is dismissing.
// If the delegate isn't there, it simply calls dismissViewControllerAnimated:completion: without checking,
// which causes exactly this bug and explains why simply implementing the delegate fixes our issue.

/*
void -[UIPopoverPresentationController dimmingViewWasTapped:](void * self, void * _cmd, void * arg2) {
    esi = self;
    edi = @selector(delegate);
    if ([esi delegate] != 0x0) {
        eax = [esi delegate];
        var_10 = @selector(popoverPresentationControllerShouldDismissPopover:);
        eax = [eax respondsToSelector:@selector(popoverPresentationControllerShouldDismissPopover:)];
        if (LOBYTE(eax) != 0x0) {
            eax = [esi presented];
            if (LOBYTE(eax) != 0x0) {
                eax = [esi dismissing];
                if (LOBYTE(eax) == 0x0) {
                    eax = [esi delegate];
                    eax = [eax popoverPresentationControllerShouldDismissPopover:esi];
                    if (LOBYTE(eax) != 0x0) {
                        esi->_isDismissingBecauseDimmingViewTapped = 0x1;
                        eax = [esi presentingViewController];
                        [eax dismissViewControllerAnimated:0x1 completion:0x0];
                        eax = [esi delegate];
                        if (eax != 0x0) {
                            eax = [esi delegate];
                            ebx = @selector(popoverPresentationControllerWillDismissPopover:);
                            eax = [eax respondsToSelector:ebx];
                            if (LOBYTE(eax) != 0x0) {
                                eax = [esi delegate];
                                eax = [eax popoverPresentationControllerWillDismissPopover:esi];
                            }
                        }
                    }
                }
            }
        }
        else {
            esi->_isDismissingBecauseDimmingViewTapped = 0x1;
            eax = [esi presentingViewController];
            [eax dismissViewControllerAnimated:0x1 completion:0x0];
            eax = [esi delegate];
            if (eax != 0x0) {
                eax = [esi delegate];
                ebx = @selector(popoverPresentationControllerWillDismissPopover:);
                eax = [eax respondsToSelector:ebx];
                if (LOBYTE(eax) != 0x0) {
                    eax = [esi delegate];
                    eax = [eax popoverPresentationControllerWillDismissPopover:esi];
                }
            }
        }
    }
    else {
        esi->_isDismissingBecauseDimmingViewTapped = 0x1;
        eax = [esi presentingViewController];
        [eax dismissViewControllerAnimated:0x1 completion:0x0];
        eax = [esi delegate];
        if (eax != 0x0) {
            eax = [esi delegate];
            ebx = @selector(popoverPresentationControllerWillDismissPopover:);
            eax = [eax respondsToSelector:ebx];
            if (LOBYTE(eax) != 0x0) {
                eax = [esi delegate];
                eax = [eax popoverPresentationControllerWillDismissPopover:esi];
            }
        }
    }
    return;
}
*/

@end
