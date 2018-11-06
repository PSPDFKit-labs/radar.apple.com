//
//  DocumentBrowserViewController.h
//  ExampleApp
//
//  Created by Douglas Hill on 06/11/2018.
//  Copyright © 2018 Example. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocumentBrowserViewController : UIDocumentBrowserViewController

- (void)presentDocumentAtURL:(NSURL *)documentURL;

@end
