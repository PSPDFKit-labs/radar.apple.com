# UIDocumentBrowserViewController additional navigation bar button items ignore accessibility label

http://openradar.appspot.com/45848685
 
## Summary
The accessibilityLabel is ignored when set on `UIBarButtonItems` set as `additionalLeadingNavigationBarButtonItems` and `additionalTrailingNavigationBarButtonItems` of a `UIDocumentBrowserViewController`.

This means custom navigation bar buttons added to a `UIDocumentBrowserViewController` are inaccessible. They just read the text ‘button’ with VoiceOver.

You can see/hear this in our app, PDF Viewer by PSPDFKit. Our settings button set in `additionalLeadingNavigationBarButtonItems` has an accessibility label set on the app side, but this is not used when using VoiceOver. You can also see this in MindNode, although I don’t know if they’re setting the `accessibilityLabel` but it’s a well made app so it’s likely they are.

I guess the `UIBarButtonItems` are serialised to pass over XPC, and the `accessibilityLabel` is not included in the serialisation.

## Steps to Reproduce:
1. Run the attached sample project. It’s the document-based app project template with a few lines added to set `additionalLeadingNavigationBarButtonItems` with an item created with an image that has an `accessibilityLabel`.
2. Enable VoiceOver.
3. Focus the circular button with the VoiceOver cursor.

## Expected Results:
VoiceOver reads “Do the thing, button”

## Actual Results:
VoiceOver reads “button”

## Version:
12.0.1
