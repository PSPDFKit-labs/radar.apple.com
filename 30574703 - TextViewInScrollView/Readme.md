# UITextView spell checking dots should be drawn according to the content scale when inside a scroll view

Summary:
When placing a UITextView inside a UIScrollView that has zooming enabled, and then updating the content scale for the subviews in the text view so that text is rendered sharp and clear when zoomed in, this has no effect on the spell checking dots.

Steps to Reproduce:
- Open the sample
- Type something that produces spell checking errors

Expected Results:
- The dots are rendered clear like the text

Actual Results:
- The dots are rendered blurry and pixelated

Regression:


Notes:
The ideal behavior would be if the text view could automatically detect if it is in a scroll view and update its content scale, however I see how this is a violation of the parent-child relationship. The second best option would be if we could just set the content scale on the text view itself. And given that all the subviews of the text view are private that seems to be the thing that ideally should work. No matter where we should set that value though, the spell checking dots should respect this and draw a sharp circle.