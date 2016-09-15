## UITextView scrolling is unreliable when contained in a zoomed-in scroll view

http://openradar.appspot.com/21180283

Summary:
When an UITextView instance is nested inside larger scrollable UIScrollView that is also zoomed in (zoomScale > 1), the text view doesn’t reliably scroll. Most of the time the parent scroll view grabs the pan gesture and it is scrolled instead. This is not an issue at zoomScale = 1.  

Steps to Reproduce:
Extract the attached archive. Take a look at the included view that show shows the issue. Open the provided example project and follow the on-screen instructions. You might need to try this a few times, but usually it’s simple to reproduce on the device (see video). 

Expected Results:
UITextView scrolling would be prioritized over the parent scroll view. 

Actual Results:
Most of the time the parent scroll view scrolls instead of the text view (but not always). 

Regression:
iOS 8.3, iPhone and iPad (a bit harder to reproduce on the simulator, but also observable)

Notes:
This cause issues in PSPDFKit forms.
