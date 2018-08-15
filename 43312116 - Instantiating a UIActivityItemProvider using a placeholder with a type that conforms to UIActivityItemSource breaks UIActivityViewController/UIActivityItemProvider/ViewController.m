//
//  ViewController.m
//  UIActivityItemProvider
//
//  Created by Oscar Swanros on 8/14/18.
//  Copyright © 2018 Oscar Swanros. All rights reserved.
//

#import "ViewController.h"
#import "ImageProvider.h"
#import "Image.h"

@interface ViewController ()
@property (nonatomic) UIButton *button;
@end

@implementation ViewController

#///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Getters

- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame:CGRectZero];
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        [_button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitle:@"Share" forState:UIControlStateNormal];
    }

    return _button;
}

#///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.button];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.button.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
                                              ]];

    // Do any additional setup after loading the view, typically from a nib.
}

#///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Selectors

- (void)buttonTapped:(UIButton *)sender {
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[self.activityItem] applicationActivities:nil];
    controller.popoverPresentationController.sourceRect = sender.frame;
    controller.popoverPresentationController.sourceView = sender;
    [self presentViewController:controller animated:YES completion:nil];
}

- (id)activityItem {
    /*
     Returning an object conforming to UIActivityItemSource makes the acitivity view controller correctly
     display the list of applications/activities that can be executed based on the
     item that's being provided.
     */
    return [Image new];

    /*
     Returning a custom UIActivityItemProvider that uses an UIActivityItemSource object
     as a placeholder does not work.

     See class for more comments.
     */
    return [ImageProvider provider];
}

@end
