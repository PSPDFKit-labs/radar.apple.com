//
//  ViewController.m
//  AnimationCompletionAndRotation
//
//  Created by Michael Ochs on 3/24/16.
//  Copyright © 2016 bitecode. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *breakAnimation;
@end

@implementation ViewController

- (IBAction)animateSomething {
    [UIView animateWithDuration:1.0 animations:^{
        self.view.backgroundColor = [UIColor colorWithHue:rand() / (CGFloat)RAND_MAX saturation:1.0 brightness:1.0 alpha:1.0];
        if (self.breakAnimation.isOn) { // this breaks the animation completion handler
            [self.view actionForLayer:self.view.layer forKey:@"position"];
        }
    } completion:^(BOOL finished) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Done" message:@"The animation is done!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL]];
        [self presentViewController:alert animated:YES completion:NULL];
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.breakAnimation.isOn) {
        // this breaks the rotation animation completion handler, resulting in a incomplete rotation
        // after the rotation the UI is frozen as -[UIApplication isIgnoringInteractionEvents] is still YES
        // and -[UIWindow isInterfaceAutorotationDisabled] returns YES.
        [self.view actionForLayer:self.view.layer forKey:@"position"];
    }
}

@end
