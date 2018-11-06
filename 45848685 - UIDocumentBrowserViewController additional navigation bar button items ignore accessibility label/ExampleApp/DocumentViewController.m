//
//  DocumentViewController.m
//  ExampleApp
//
//  Created by Douglas Hill on 06/11/2018.
//  Copyright © 2018 Example. All rights reserved.
//

#import "DocumentViewController.h"

@interface DocumentViewController()

@property IBOutlet UILabel *documentNameLabel;

@end

@implementation DocumentViewController
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Access the document
    [self.document openWithCompletionHandler:^(BOOL success) {
        if (success) {
            // Display the content of the document, e.g.:
            self.documentNameLabel.text = self.document.fileURL.lastPathComponent;
        } else {
            // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
        }
    }];
}

- (IBAction)dismissDocumentViewController {
    [self dismissViewControllerAnimated:YES completion:^ {
        [self.document closeWithCompletionHandler:nil];
    }];
}

@end
