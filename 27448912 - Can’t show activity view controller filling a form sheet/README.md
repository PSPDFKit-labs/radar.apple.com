# Can’t show activity view controller filling a form sheet

Radar 27448912

Summary:
On iOS 9 on a small iPad, Pages shows an activity view controller filling a form sheet (see attached screen shot). (Note that Pages uses a popover on large iPad Pro on iOS 10 — not sure which change causes this.)

We can't reproduce this behaviour.

Steps to Reproduce:
1. Open Pages for iOS on a small iPad, iOS 9
2. Go into a document
3. Go to the Send a Copy screen
4. Progress until the activity view controller is shown
5. Notices it fills the form sheet
6. Run the attached sample project on an iPad
7. Notice the activity view controller is shown as a popover

Expected Results:
I’m not quite sure what I expect UIKit to do by default in this situation, but it would be nice to have options to be able to do what Page does.

Since the activity view controller is like a popover and is being presented in a horizontally compact environment, one logical conclusion is that it should be shown full screen by default, which is clearly ridiculous.

Actual Results:
In Pages, the activity view controller is shown filling the form sheet, not as a popover. We can’t replicate this behaviour. When we present an activity view controller from a form sheet the activity view controller is in a popover.

When the activity view controller is presented from a popover, it appears as a second popover on iOS 9 and as a sheet inside the first popover on iOS 10. The official line seems to be that the trait collection determines presentation styles, but this is not what UIKit does since both in both the form sheet and popover case we are presenting an activity view controller from a compact width.

Version:
iOS 9 (not sure exact version) and iOS 10 beta 2

Notes:
I think trait collections are an oversimplification, and the UIKit behaviour seems to back me up on this.

Configuration:
iPad Air 2 on iOS 9 with Pages and iPad Pro big on iOS 10 beta 2 with my sample project

Attachments:
'pages-sheet-in-form-sheet.jpg' and 'activityviewcontroll-form-sheet.zip' were successfully uploaded.