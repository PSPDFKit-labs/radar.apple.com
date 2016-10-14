//
//  AppDelegate.m
//  PasteboardNotification
//
//  Created by Michael Ochs on 10/14/16.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic) id pasteboardObserver;

@end

@implementation AppDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        __weak typeof(self) weakSelf = self;
        self.pasteboardObserver = [NSNotificationCenter.defaultCenter addObserverForName:UIPasteboardChangedNotification object:pasteboard queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
            typeof(weakSelf) self = weakSelf;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Pasteboard item detected" message:@"A UIPasteboardChangedNotification notification was triggered." preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL]];
            [self.window.rootViewController presentViewController:alert animated:YES completion:NULL];
        }];
    }
    return self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self.pasteboardObserver];
}

@end
