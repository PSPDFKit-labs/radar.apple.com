Summary:

The system autocorrect selection indicator fails to update it’s position and size in some cases. One simple example is a configuration where a UITextView is embedded in another UIScrollView. If we have an autocorrect selection window currently visible and scroll the outer scroll view, the selection does not update (this worked on iOS 7, but does not on iOS 8). A similar problem occurs if we, for instance, change the text size while the autocorrect selection is visible. The selection window does not resize to match the new text frame (happens on iOS 7 as well). Changing the text view frame also brakes layout. 

Steps to Reproduce:

Run the attached sample project. 
Write some misspelled text in the orange text view to trigger the autocorrect selection indicator. 
Scroll the outer (white) scroll view or press the resize button below the text view while the autocorrect indicator is visible. 

Expected Results:

The autocorrect view would match the text position. 

Actual Results:

The autocorrect view stays at its original position and does not resize.

Regression:

iOS 8.1.2, some problems are also apparent on iOS 7. Happens on iPhone and iPad. 

Notes:

Scroll (GIF): http://cl.ly/image/433j3w090X28
Resize before: http://cl.ly/image/3o2M373C0v42
Resize after: http://cl.ly/image/400o110H2W0w
