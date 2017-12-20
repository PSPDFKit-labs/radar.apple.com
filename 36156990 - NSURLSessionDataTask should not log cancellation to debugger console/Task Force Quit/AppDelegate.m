//
//  AppDelegate.m
//  Task Force Quit
//
//  Copyright © 2017 PSPDFKit GmbH. All rights reserved.
//

@import UIKit

@interface AppDelegate : UIResponder <UIApplicationDelegate, NSURLSessionTaskDelegate>

@property (nonatomic) UIWindow *window;
@property (nonatomic) NSURLSession *session;
@property (atomic) NSURLSessionTask *currentTask;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.ephemeralSessionConfiguration delegate:self delegateQueue:nil];

    return YES;
}

/// Kicks off a new request that will be cancelled while running
- (IBAction)makeRequest:(id)sender {
    if (self.currentTask != nil) {
        NSLog(@"Not making request: still got one!");
        return;
    }

    // PSPDFKit always upgrades to HTTPS, so we use this to cancel the request after it has started, but before it has finished
    NSURL *home = [NSURL URLWithString:@"http://pspdfkit.com"];
    NSURLRequest *GETHome = [NSURLRequest requestWithURL:home cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:3600];
    self.currentTask = [self.session dataTaskWithRequest:GETHome];
    [self.currentTask resume];
}

#pragma mark - NSURLSession(Task)Delegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler  {
    // cancel the task before we would allow it to proceed
    [task cancel];
    [NSOperationQueue.mainQueue addOperationWithBlock:^{
        completionHandler(request);
    }];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if ((error.code == NSUserCancelledError && [error.domain isEqualToString:NSCocoaErrorDomain])
        || (error.code == NSURLErrorCancelled && [error.domain isEqualToString:NSURLErrorDomain])) {
        // we really don’t care about cancellation
    } else if (error) {
        NSLog(@"Uh oh: %@", error);
    } else {
        NSLog(@"completed successfully — should **NEVER** be printed");
    }
    self.currentTask = nil;
}

@end
