//
//  ViewController.m
//  Pop under
//
//  Copyright © 2019 PSPDFKit GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic) IBOutlet UITextView *initialFirstResponder;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.initialFirstResponder selectAll:nil];
}

@end
