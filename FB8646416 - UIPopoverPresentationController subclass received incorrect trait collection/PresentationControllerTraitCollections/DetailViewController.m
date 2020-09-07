//
//  DetailViewController.m
//  PresentationControllerTraitCollections
//
//  Created by Nishant Desai on 07/09/20.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic) UIButton *dismissControllerButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.systemGroupedBackgroundColor;

    UIButton *button = [[UIButton alloc] initWithFrame:self.view.bounds];
    [button setTitle:@"Dismiss Controller" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismissModalPresentation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    self.dismissControllerButton = button;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    self.dismissControllerButton.frame = self.view.bounds;
}

- (void)dismissModalPresentation {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
