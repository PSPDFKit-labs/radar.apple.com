# FB11990308: Selection handles are blurry when text input is inside zoomed scroll view

## Which area are you seeing an issue with?

UIKit

## What type of feedback are you reporting?

Incorrect/Unexpected Behavior

## Description

## Summary

When using a text input view placed inside a zooming UIScrollView, the selection handles/knobs (the dots at the start and end of a text selection to resize it) of the text selection of the text input view are not updated for the current zoom scale, and they will look more blurry the further you zoom in.

The same behavior happens with UITextView, UITextField, and when using a custom UITextInput, that uses UITextInteraction.

Even setting UIView.contentScaleFactor on the text input view doesn't make the selection handles crisp, like it does for the containing text.

This was tested with iOS 16.2.

## Expected Behavior

When zooming in a scroll view that contains a text input view the text selection handles should stay crisp and not look blurry when zoomed in.

## Actual Results

Text selection handles look blurry the more you zoom in the scroll view containing the text input view.

## Steps to reproduce 

- Place a UITextView/UITextField/UITextInput inside a scroll view
- Zoom in
- Select text
- See that the selection handles are blurry

This can be reproduced with the attached ZoomedTextViewExample project.

## Attachments

ZoomedTextViewExample.zip
