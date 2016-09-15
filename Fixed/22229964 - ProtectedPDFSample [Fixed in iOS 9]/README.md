## CGPDFDocumentCreateWithURL fails for password protected PDFs

http://openradar.appspot.com/22229964

Summary:

Starting with iOS 9 beta 5 (Xcode 7 beta 5) CGPDFDocumentCreateWithURL returns a NULL CGPDFDocumentRef for password protected PDFs. The same code works fine on iOS 8.4 and was also working fine on previous iOS 9 beta versions. The function works as expected for all non-password protected PDFs on all iOS versions. This is a serious problem - one we can not work around easily. 

Steps to Reproduce:

Open the provided example project. Run it on iOS 9 and observe the assertion that gets triggered. Inspect the code in ViewController.m. Run the same on iOS 8.4 and you’ll get no assertion hits. 

Expected Results:

CGPDFDocumentCreateWithURL  should returns a valid non-null CGPDFDocumentRef for password protected PDFs, just like for non-password protected PDFs. 

Actual Results:

CGPDFDocumentCreateWithURL returns a valid null CGPDFDocumentRef for password protected PDFs.

Regression:

iOS 9 beta 5 only
