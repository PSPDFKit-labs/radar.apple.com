Implementing certain NSFilePresenter callbacks can lead to skipped presentedItemDidChange notifications
Originator:	matej	
Number:	rdar://32976151	Date Originated:	26-Jun-2017 09:03 AM
Status:	Open	Resolved:	
Product:	iOS + SDK	Product Version:	iOS 10, iOS 11b2
Classification:	Security	Reproducible:	Always
 
Summary:
During the implementation file coordination and NSFilePresenter support in PSPDFKit, we noticed that one of our tests started failing as soon as we implemented support for NSFilePresenter calls such as  accommodatePresentedItemDeletionWithCompletionHandler: savePresentedItemChangesWithCompletionHandler:. The test simulated simultaneous write access from two NSFilePresenter-conforming objects to a single file on disk. Without the implementing the above mentioned methods, we saw presentedItemDidChange being called on both object, as the other object modified it. With the calls implemented, one of the two presentedItemDidChange calls was no longer invoked, which caused our test to fail.

Steps to Reproduce:
Build and run the provided FilePresenterCallbacksExample on the iOS simulator on on an iOS device. Follow the on screen instructions. Later uncomment the commented out code in Document.m and compare the results of running the example app. 

Expected Results:
presentedItemDidChange would be called for both objects when the other writer modifies it, regardless of whether accommodatePresentedItemDeletionWithCompletionHandler: and/or savePresentedItemChangesWithCompletionHandler and/or other similar methods are implemented.

Actual Results:
presentedItemDidChange is no longer called for one of the two participating objects after implementing accommodatePresentedItemDeletionWithCompletionHandler: and/or savePresentedItemChangesWithCompletionHandler and/or other similar methods

Version:
iOS 10, iOS 11b2

Notes:
The example produces the same results with iOS SDK 10 and 11 (b2). The example app can be run on the iOS simulator or a physical device with the same results. 

I discussed this in the WWDC File Presenters lab with Kevin. He told me it’s most likely a bug for which a reproducible sample would be helpful. 

Here are some of my debugging notes (this is based on our framework test case). https://gist.github.com/matej/874b99781e7b616f23e193381d6e9831
Comments
Example project
https://github.com/PSPDFKit-labs/radar.apple.com/tree/master/32976151%20-%20FilePresenterCallbacksExample

By matej at June 26, 2017, 7:07 a.m. (reply...)
Add a comment 
Please note: Reports posted here will not necessarily be seen by Apple. All problems should be submitted at bugreport.apple.com before they are posted here. Please only post information for Radars that you have filed yourself, and please do not include Apple confidential information in your posts. Thank you!

