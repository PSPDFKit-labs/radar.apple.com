Peter Steinberger08-Jun-2016 10:08 PM

I can no longer reproduce the issue in iOS 9.3.2 Was this fixed?
Peter Steinberger02-Mar-2015 10:01 PM

Summary:
Using WKWebView results in many internal exceptions because of selectors that are not implemented.

Steps to Reproduce:
Open WKWebViewCrash example. Wait.

Expected Results:
Should not throw exceptions.

Actual Results:
Throws exceptions.

     2015-03-02 21:55:26.797 WKWebViewCrash[88089:7781658] -[WKCompositingView setScrollsToTop:]: unrecognized selector sent to instance 0x7f9b7ae2ec60
     2015-03-02 21:55:26.802 WKWebViewCrash[88089:7781658] *** WebKit discarding exception: <NSInvalidArgumentException> -[WKCompositingView setScrollsToTop:]: unrecognized selector sent to instance 0x7f9b7ae2ec60
     2015-03-02 21:55:26.802 WKWebViewCrash[88089:7781658] -[WKCompositingView setScrollsToTop:]: unrecognized selector sent to instance 0x7f9b7ae2b900
     2015-03-02 21:55:26.802 WKWebViewCrash[88089:7781658] *** WebKit discarding exception: <NSInvalidArgumentException> -[WKCompositingView setScrollsToTop:]: unrecognized selector sent to instance 0x7f9b7ae2b900
     2015-03-02 21:55:26.803 WKWebViewCrash[88089:7781658] -[WKCompositingView setScrollsToTop:]: unrecognized selector sent to instance 0x7f9b7ae2aa10
     2015-03-02 21:55:26.803 WKWebViewCrash[88089:7781658] *** WebKit discarding exception: <NSInvalidArgumentException> -[WKCompositingView setScrollsToTop:]: unrecognized selector sent to instance 0x7f9b7ae2aa10
     2015-03-02 21:55:26.854 WKWebViewCrash[88089:7781658] -[WKCompositingView setContentSize:]: unrecognized selector sent to instance 0x7f9b7ae2b900
     2015-03-02 21:55:26.854 WKWebViewCrash[88089:7781658] *** WebKit discarding exception: <NSInvalidArgumentException> -[WKCompositingView setContentSize:]: unrecognized selector sent to instance 0x7f9b7ae2b900

Regression:
This API doesn’t exist on iOS 7.

Notes:
Tested with 8.1.3. Tried with iOS 8.3b2 as well, same logs.

Since this doesn’t appear on every website, better look into this soon before we change the website again.