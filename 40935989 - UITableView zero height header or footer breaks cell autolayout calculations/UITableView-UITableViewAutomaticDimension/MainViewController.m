//
//  MainViewController.m
//  UITableView-UITableViewAutomaticDimension
//
//  Created by Marcin Krzyzanowski on 08/06/2018.
//  Copyright © 2018 Marcin Krzyzanowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "TableViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Press me!" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonDidPressed:) forControlEvents:UIControlEventTouchUpInside];

    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];

    [NSLayoutConstraint activateConstraints:@[
        [self.view.centerXAnchor constraintEqualToAnchor:button.centerXAnchor],
        [self.view.centerYAnchor constraintEqualToAnchor:button.centerYAnchor]
    ]];
}

- (void)buttonDidPressed:(id)button {
    TableViewController *vc = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
