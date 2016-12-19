//
//  ViewController.m
//  LocationInViewSample
//
//  Created by Matej Bukovinski on 19/12/2016.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)didPan:(UIPanGestureRecognizer *)sender {
    CGPoint locationInNil = [sender locationInView:nil];
    CGPoint locationInWindow = [sender locationInView:sender.view.window];

    NSLog(@"nil: %@ ==? window: %@", NSStringFromCGPoint(locationInNil), NSStringFromCGPoint(locationInWindow));

    NSAssert(CGPointEqualToPoint(locationInNil, locationInWindow), @"According to the documentation, a nil parameter should return the point in the window coordinate system.");
}

- (IBAction)didLongPress:(UILongPressGestureRecognizer *)sender {
    CGPoint locationInNil = [sender locationInView:nil];
    CGPoint locationInWindow = [sender locationInView:sender.view.window];

    NSLog(@"nil: %@ ==? window: %@", NSStringFromCGPoint(locationInNil), NSStringFromCGPoint(locationInWindow));

    NSAssert(CGPointEqualToPoint(locationInNil, locationInWindow), @"According to the documentation, a nil parameter should return the point in the window coordinate system.");
}

@end
