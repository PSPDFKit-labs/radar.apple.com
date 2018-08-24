## Label with large title text style doesn't resize the font size when Dynamic Type setting changes

Summary:
When creating a UILabel, with the font set to a preferred font with text style UIFontTextStyleLargeTitle, adjustsFontForContentSizeCategory is not honored when the Dynamic Type font size setting is changed.

Consider the following code:
let label = UILabel()
label.text = “Text”
label.font = UIFont.preferredFont(forTextStyle: .largeTitle) 
label.adjustsFontForContentSizeCategory = true

When the label is shown, and the Dynamic Type setting is changed (either via the device’s Settings.app, or via the Accessibility Inspector), the label does not update its font size, for the new content size category.

As a workaround, the font on the label can be set again, every time the Dynamic Type setting changes, like this:

NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: nil, queue: nil) { notification in
    label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
}

This shouldn’t however be needed, since adjustsFontForContentSizeCategory has been enabled, and the font was vended by UIFont.preferredFont(forTextStyle:).

Everything works fine when using a different text style apart from UIFontTextStyleLargeTitle.

Steps to Reproduce:
- Run the attached sample project.
- Change the Dynamic Type font size via the Accessibility Inspector.


Expected Results:
The label with the large title text style resizes its font, to match the new Dynamic Type setting.

Actual Results:
The label with the large title text style does not resize its font. 
While all the other labels (using all the other available UIFontTextStyles) do change.

Version:
11.4.1 & 12b10
