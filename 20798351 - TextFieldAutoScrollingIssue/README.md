## UITextField fist reponder auto-scrolling can scroll away from the text input position

http://openradar.appspot.com/20798351

Summary:

On iOS 8 UITextField gained the ability to scroll it’s scroller (parent scroll view) in order to make the text view visible when gaining first responder status. This is done by looking up the parent scroll view and than using it’s scrollRectToVisible:animated: method passing the appropriately converted text field frame. However due to how scrollRectToVisible:animated: behaves, doing that can lead to the scroll view actually scrolling away from the input caret position to the end of the text field, thereby potentially moving the input position off screen.

Steps to Reproduce:

Open the attached sample project and run the sample application on either iPhone and iPad (you can also use the simulator). There are on screen instructions that show how to reproduce the issue.  

Expected Results:

When selecting the scroll view should scroll to the text input caret position. 

Actual Results:

The scroll view scrolls to the very end of the text view, moving the input caret offscreen. 

Regression:

iPhone, iPad, and iOS simulator iOS 8+ (including 8.3). On iOS 7 nothing happens (the scrolling code was obviously not implemented ant that point). 

Notes:

This can not only happen for very large (wide) text fields, but also if we’re zoomed into a view that can contain a text field (as it does for us at PSPDFKit). The sample project contains a possible workaround in ViewController.m (set FIRST_RESPONDER_SCROLL_WORKAROUND_ENABLED to 1 to try it out). However this workaround depends on a private UITextFieldDelegate method named _textFieldShouldScrollToVisibleWhenBecomingFirstResponder:. It would be very useful if this method is made available as part of the public API in addition to a fix for the outlined issue.
