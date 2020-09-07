//
//  ViewController.m
//  PresentationControllerTraitCollections
//
//  Created by Nishant Desai on 07/09/20.
//

#import "ViewController.h"

#import "DetailViewController.h"
#import "CustomPresentationController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic) UIButton *presentControllerButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [[UIButton alloc] initWithFrame:self.view.bounds];
    [button setTitle:@"Present Controller" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(presentModalController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    self.presentControllerButton = button;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    self.presentControllerButton.frame = self.view.bounds;
}

- (void)presentModalController {
    // Present another controller using our popover custom presentation controller subclass.
    DetailViewController *detailController = [[DetailViewController alloc] init];
    detailController.modalPresentationStyle = UIModalPresentationCustom;
    detailController.transitioningDelegate = self;

    [self presentViewController:detailController animated:YES completion:nil];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    CustomPresentationController *presentationController = [[CustomPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];

    UIButton *presentControllerButton = self.presentControllerButton;
    presentationController.sourceView = presentControllerButton;
    presentationController.sourceRect = (CGRect){ .origin = presentControllerButton.titleLabel.center, .size = presentControllerButton.titleLabel.bounds.size };

    return presentationController;

}

@end
