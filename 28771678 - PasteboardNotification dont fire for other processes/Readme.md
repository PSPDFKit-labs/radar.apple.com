Summary:
When listening for notifications from UIPasteboard (e.g. UIPasteboardChangedNotification), this notification is only triggered for changes that originate from the same process. If another app modifies the pasteboard, this is not triggered.

This used to be okay in the past, where you could easily check the pasteboard e.g. on didBecomeActive calls, but nowadays with things like SplitScreen there can be more than one app in the foreground at the same time. The notifications not working only leaves polling as an option.

Steps to Reproduce:
1. Open the sample app on an iPad
1b. If you want to check if everything is working, select text from the text view of the app and copy it – this will produce an alert as the notification was triggered
2. Open another app in SplitScreen (e.g. 50%/50%)
3. Select some text in the other app
4. Choose copy from the menu that shows up when selecting text.

Expected Results:
As the sample app listens to UIPasteboardChangedNotification notifications and triggers an alert if one arrives, I would expect this dialog to appear here.

Actual Results:
Nothing happens

Version:
iOS 10.0.1

Notes:
This also doesn't work when completely switching to another app in step 2, instead of switching to SplitScreen and then come back to this app after copying something.
According to the almighty StackOverflow this used to work as well, even though I don't know if that's true.

Configuration:
iPad Pro 12.9", Xcode 8