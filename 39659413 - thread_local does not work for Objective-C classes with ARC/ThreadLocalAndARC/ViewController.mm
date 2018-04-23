//
//  ViewController.m
//  ThreadLocalAndARC
//
//  Created by Peter Steinberger on 23.04.18.
//  Copyright © 2018 Peter Steinberger. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

static thread_local NSNumber *testMRRVariable = @(10);

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"MRR works: %@", testMRRVariable);
}

@end
