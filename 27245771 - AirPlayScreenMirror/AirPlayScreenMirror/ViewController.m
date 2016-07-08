//
//  ViewController.m
//  AirPlayScreenMirror
//
//  Created by Michael Ochs on 7/8/16.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *screenInfoLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDidConnect:) name:UIScreenDidConnectNotification object:nil];
}

- (void)screenDidConnect:(NSNotification *)notification
{
    UIScreen *connectedScreen = [notification object];
    NSLog(@"Screen connected with size: %@ & scale: %g", NSStringFromCGSize(connectedScreen.bounds.size), connectedScreen.scale);
    self.screenInfoLabel.text = [NSString stringWithFormat:@"Screen connected with size: %@ & scale: %g", NSStringFromCGSize(connectedScreen.bounds.size), connectedScreen.scale];
}

@end
