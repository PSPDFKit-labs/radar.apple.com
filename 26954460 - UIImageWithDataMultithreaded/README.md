## Clarify if creation of UIImage on background threads is safe

http://openradar.appspot.com/26954460

Area:
UIKit

Summary:
There's been some confusion if *creating* UIImage objects from background thread is safe. The documentation mentions usage, but this does not necessarily mean that objects can be *created* on background threads. And there was a race condition in iOS 9.

Steps to Reproduce:
Read https://github.com/AFNetworking/AFNetworking/issues/2572#issuecomment-227895102

It contains sample code as well (also attached here). This seems to be fixed in iOS 10 (both via testing and my research) BUT the documentation is unclear about it.

Expected Results:
This should be clearly documented.

Actual Results:
Documentation is too vague

Version:
iOS 9.3.2/10b1

Notes:


Configuration:
Xcode 7.3.1/8b1
