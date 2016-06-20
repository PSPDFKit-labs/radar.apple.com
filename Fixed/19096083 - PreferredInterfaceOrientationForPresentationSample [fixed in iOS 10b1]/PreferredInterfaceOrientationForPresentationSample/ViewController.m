//
//  ViewController.m
//  PreferredInterfaceOrientationForPresentationSample
//
//  Created by Matej Bukovinski and Peter Steinberger on 28. 11. 14.
//  Copyright (c) 2014 PSPDFKit. All rights reserved.
//

#import "ViewController.h"
#import "ModalController.h"
#import "NavigationController.h"

@implementation ViewController

- (IBAction)showModalPressed:(id)sender {
    ModalController *modal = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(ModalController.class)];
    NavigationController *navController = [[NavigationController alloc] initWithRootViewController:modal];

    // The root problem is that we configure the modal presenation style as a form sheet.
    // This should simply be a NOP on iPhone, but later on has other impications that lead to our bug.
    navController.modalPresentationStyle = UIModalPresentationFormSheet;


    // Later on in the code flow, we do some checks on the presentation controller.
    // Nothing is modified, but the controller is accessed.
    //
    // However, merely *accessing* the presentation controller will invoke -[UIViewController _setTemporaryPresentationController:],
    // creating a temporary _UIFormSheetPresentationController object which makes
    // _preferredInterfaceOrientationForPresentationInWindow:fromInterfaceOrientation: go through another code path later on.
    [navController presentationController];


    /* The presenter has logic to restore the modalPresentationStyle back to UIModalPresentationFullScreen
     in -[UIViewController _presentViewController:withAnimationController:completion:].
     
     This is the pseudo-code in question:
                         if ([var_18 _temporaryPresentationController] == 0x0) {
                            esi = [var_10 traitCollection];
                            edi = @selector(modalPresentationStyle);
                            if (([var_18 modalPresentationStyle] == 0x10) || ([var_18 modalPresentationStyle] == 0x2)) {
                                    if (objc_msgSend(STK0, STK-1) == 0x1) {
                                            [var_18 setModalPresentationStyle:0x0];
                                    }
                            }

     Our access to presentationController creates the temporary presentation controller, and thus changes execution flow.
     The modalPresentationStyle doesn't get reset correctly and further down in the execution chain
     _preferredInterfaceOrientationForPresentationInWindow:fromInterfaceOrientation: goes through another code chain and doesn't call
     preferredInterfaceOrientationForPresentation, thus presenting the controller in portrait.
     */
    [self presentViewController:navController animated:YES completion:nil];
}

@end
