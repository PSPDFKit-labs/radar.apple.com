//
//  ViewController.m
//  WKWebViewCrash
//
//  Created by Peter Steinberger on 02/03/15.
//  Copyright (c) 2015 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"
@import WebKit;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];

    /*
     Prints the following:

     2015-03-02 21:55:26.797 WKWebViewCrash[88089:7781658] -[WKCompositingView setScrollsToTop:]: unrecognized selector sent to instance 0x7f9b7ae2ec60
     2015-03-02 21:55:26.802 WKWebViewCrash[88089:7781658] *** WebKit discarding exception: <NSInvalidArgumentException> -[WKCompositingView setScrollsToTop:]: unrecognized selector sent to instance 0x7f9b7ae2ec60
     2015-03-02 21:55:26.802 WKWebViewCrash[88089:7781658] -[WKCompositingView setScrollsToTop:]: unrecognized selector sent to instance 0x7f9b7ae2b900
     2015-03-02 21:55:26.802 WKWebViewCrash[88089:7781658] *** WebKit discarding exception: <NSInvalidArgumentException> -[WKCompositingView setScrollsToTop:]: unrecognized selector sent to instance 0x7f9b7ae2b900
     2015-03-02 21:55:26.803 WKWebViewCrash[88089:7781658] -[WKCompositingView setScrollsToTop:]: unrecognized selector sent to instance 0x7f9b7ae2aa10
     2015-03-02 21:55:26.803 WKWebViewCrash[88089:7781658] *** WebKit discarding exception: <NSInvalidArgumentException> -[WKCompositingView setScrollsToTop:]: unrecognized selector sent to instance 0x7f9b7ae2aa10
     2015-03-02 21:55:26.854 WKWebViewCrash[88089:7781658] -[WKCompositingView setContentSize:]: unrecognized selector sent to instance 0x7f9b7ae2b900
     2015-03-02 21:55:26.854 WKWebViewCrash[88089:7781658] *** WebKit discarding exception: <NSInvalidArgumentException> -[WKCompositingView setContentSize:]: unrecognized selector sent to instance 0x7f9b7ae2b900
     */
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://pspdfkit.com"]]];
}

@end
