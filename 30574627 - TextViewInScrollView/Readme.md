# UITextView spell checking is huge and overlaps next line's text when dealing with small font sizes

Summary:
When dealing with very small font sizes (in this case 6pt), the red spell-checking dots in a text view are huge compared to the font size. They get so big that they even overlap with the text in the next line. The dots should shrink together with the text if the font size reaches a certain minimum.

Steps to Reproduce:
- Open the example
- Type something that is miss spelled

Expected Results:
- The red line’s appearance matches the size of the font, like a regular text underline would.

Actual Results:
- The red dots are huge, they even overlap with text in the next line

Regression:


Notes:
