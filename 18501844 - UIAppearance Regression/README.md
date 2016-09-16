## Regression in UIAppearance apply rules between iOS 8.0 and iOS 8.1

http://openradar.appspot.com/18501844

Summary:
The attached sample shows the correct UIAppearance tinging on iOS 8.0, but doesn't apply tinting on iOS 8.1

Steps to Reproduce:
1. Start UIAppearance Regression.xcodeproj in Xcode 6.0 and Xcode 6.1b3
2. Observe nav bar is blue in 6.0, but white in 6.1b3.

Expected Results:
Nav bar should be always blue.

Actual Results:
Nav bar tinting is not applied in 8.1b1.

Version:
iOS 8.0 and iOS 8.1b1

Notes:
This seems to be related to the PSPDFNavigationController and the way we forward rotation information. Something in there triggers UIAppearance evaluation and this changed in 8.1. I found out after trying to reproduce this in a small simulated example.

Configuration:
Resizable iPad Simulator
