Peter Steinberger24-Nov-2014 09:49 AM

Summary:
UIAlertController in ActionSheet configuration changes size, if we present another alert view on top that has a text field.
Instead of further explanation, just watch this animated gif: http://cl.ly/image/0x1r0d3w2M3q

Steps to Reproduce:
Open attached example, observe weird behavior.

Expected Results:
The Action Sheet has no reason to change it’s size and should keep the frame it had prior to showing the alert.

Actual Results:
Action Sheet is drunk and resizes :)

Regression:
Works if we use UIActionSheet and UIAlertView on iOS 7.

Notes:
UIAlertController is a great change. Having to think about controllers is annoying and the present/dismissal logic could be more forgiving, but overall the API design of UIAlertController is great, love the actions+blocks.


Fixed in iOS 8.3