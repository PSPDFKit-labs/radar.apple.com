File coordination and NSFilePresenter fail silently when passing a non-fileURL URL
Originator:	matej	
Number:	rdar://32976447	Date Originated:	26-Jun-2017 09:33 AM
Status:	Open	Resolved:	
Product:	iOS + SDK	Product Version:	iOS 10, 11b2
Classification:	Security	Reproducible:	Always
 
Summary:
File coordination appears to fail silently without any warning (or assertions) when passing it an URL that is not a file URL (ifFileURL == NO). This can happen if the URL is say mistakenly initialized using [NSURL URLWithString:documentPath] instead of using [NSURL fileURLWithPath:documentPath]. 

Steps to Reproduce:
Run the provided example and follow the on screen instructions to reproduce the issue. See the commented section in ViewController.m to change the behavior of the example. 

Expected Results:
NSFileCoordinator and NSFilePresenter would warn by logging in the console (or even assert?) is they receive URLs that they do not support. 

Actual Results:
NSFileCoordinator and NSFilePresenter fail silently. Not file coordination is apparently performed (there is a noticeable thread race in the example) and no file coordination update cals are invoked. At the same the file operations can succeed normally (the example uses NSFileHandle to write data).  

Version:
iOS 10, 11b2

Notes:
URLWithString:

(lldb) p documentURL
(NSURL *) $1 = 0x0000600000091300 @"/Users/matej/Library/Developer/CoreSimulator/Devices/C50BB0A5-06ED-4802-950F-F3457ED7579D/data/Containers/Data/Application/B68CE42E-618F-48B5-94C1-C18549901518/Documents/file.txt"

fileURLWithPath:

(lldb) p documentURL
(NSURL *) $0 = 0x00006000000b3e00 @"file:///Users/matej/Library/Developer/CoreSimulator/Devices/C50BB0A5-06ED-4802-950F-F3457ED7579D/data/Containers/Data/Application/E46DDF1F-E1D2-4690-87AD-5AE55D51DE96/Documents/file.txt"
Comments
Example project
https://github.com/PSPDFKit-labs/radar.apple.com/tree/master/32976447%20-%20FileURLCoordinationExample