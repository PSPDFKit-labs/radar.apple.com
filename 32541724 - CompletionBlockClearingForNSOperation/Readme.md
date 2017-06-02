NSOperation should clear completionBlock after running
Originator:	steipete	
Number:	rdar://32541724	Date Originated:	02-Jun-2017 12:34 PM
Status:	Open	Resolved:	
Product:	iOS + SDK	Product Version:	10.3.2
Classification:	Other Bug	Reproducible:	Always
 
Summary:
NSOperation promises to clear the completionBlock after running:

>In iOS 8 and later and macOS 10.10 and later, this property is set to nil after the completion block begins executing.

However, this is not true for iOS, it only happens on macOS.

Steps to Reproduce:
Run attached samples (one for iOS, one for macOS)
Observe output.

Expected Results:
Log:
Optional((Function))
nil
nil
nil


Actual Results:
iOS 10.3.2:

Optional((Function))
Optional((Function))
Optional((Function))
nil

macOS 10.12.5:
Optional((Function))
nil
nil
nil


Version:
10.3.2

Notes:
Not sure if this is a regression or never worked on iOS. You can also test this in a Playground: https://gist.github.com/bjhomer/e866a405c425e83c8cad53a8ee8f055e