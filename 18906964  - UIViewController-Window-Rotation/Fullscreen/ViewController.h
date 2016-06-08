//
//  ViewController.h
//  Fullscreen
//
//  Created by Matthias Plappert on 06/11/14.
//  Copyright (c) 2014 Matthias Plappert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIView *containerView;

- (IBAction)transitionByUsingNewController:(id)sender;
- (IBAction)transitionByReUsingController:(id)sender;

@end
