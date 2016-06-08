In PSPDFKit we're using UIScrollView content insets to center PDF page views inside the viewport. In order to correctly center pages of certain sizes, we might end up with values that are fractions (say contentInset = UIEdgeInsetsMake(0, 7.5, 0, 7.5)). Setting insets like that works fine.

In order to correctly position the page, the contentOffset also needs to be adjusted according to to set contentInset. In the above case contentOffset.x would need to be -7.5.

We noticed that while sometimes this works fine, we also get cases where the set contentInset gets rounded to the nearest integer (-8.0 for the given example). This seems to be especially true during initial view setup. This breaks out layout code and leaves us with incorrectly positioned pages and small gaps.

Steps to Reproduce:

Open ScrollViewCenteringExample on the iPad simulator, running iOS 9. In the console you’ll see output that is the result of an overridden UIScrollView setContentOffset: method. 

Set: {0, 0}, Applied: {0, 0}
Set: {0, 0}, Applied: {0, 0}
Set: {-8, 0}, Applied: {-8, 0}
Set: {-7.5, 0}, Applied: {-8, 0}

Observe that we’re setting fractional scroll offsets, but the end result is a rounded value. 

Expected Results:

The value would not be rounded (offset -7.5, 0). 

Actual Results:

The content offset is rounded (offset -8, 0) and the page is off-center. 

Regression:

The rounding is not always applied. The end results seem to be very depended on the sequence of (internal layout) methods called. For example, when the above project used Auto Layout to lay out the scroll view in the storyboard, the content was not offset at the end, but there were still intermediate states where the content offset was incorrect (rounded). 

Set: {0, 0}, Applied: {0, 0}
Set: {0, 0}, Applied: {0, 0}
Set: {0, 0}, Applied: {0, 0}
Set: {-7.5, 0}, Applied: {-8, 0}
Set: {-7.5, 0}, Applied: {-7.5, 0}

Notes:

Digging into the code with the debugger revealed that using -[UIScrollView setContentInset:] triggers -[UIScrollView(UIScrollViewInternal) _adjustContentOffsetIfNecessary] which sets rounded values for the contentOffset. We tried to manually correct the value by setting the contentOffset explicitly after setting the inset, but noticed that even setContentOffset rounds internally. This appears to be only happening in some cases, mainly depending on the value of two private UIScrollView flags (disableContentOffsetRounding and alwaysDisableContentOffsetRounding).

Still issue in iOS 9.3.2