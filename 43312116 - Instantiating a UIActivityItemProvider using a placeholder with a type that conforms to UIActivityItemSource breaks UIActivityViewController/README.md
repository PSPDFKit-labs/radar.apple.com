Summary:
When interacting with the UIActivityViewController class, you can provide a list of items to share. The actual data processing for those items can be delegated to a different object that does the heavy lifting once the final activity has been decided.

There are two ways to accomplish this. UIActivityItemProvider and UIActivityItemSource.

You can create a UIActivityItemProvider subclass to provide the actual data, providing a placeholder item that represents the final data that's the provider generates when requested.

According to -[UIActivityItemProvider initWithPlaceholderItem:] documentation (https://developer.apple.com/documentation/uikit/uiactivityitemprovider/1620463-initwithplaceholderitem?language=objc):

placeholderItem:
An object that can stand in for the actual object you plan to create. The contents of the object may be empty but the class of the object must match the class of the object you plan to provide later.

However, if the item that's provided as a placeholder is of a class that itself conforms to UIActivityItemSource, the whole system breaks apart and the resulting UIActivityViewController won't actually show the available activities for the given item.

I believe this is a serious omission and the two available ways to provide information to the activity controller shouldn't clash when used together.

Steps to Reproduce:
1. Download the sample project, run.
2. Tap the "Share" button on the display.
3. Observe how the activity view controller displays the options to share an image.
4. Comment ViewController.m:L65, re-run the project.
5. Tap the "Share" button on the display.
6. Notice how the activity view controller displays an empty list of available activities even though, technically, the placeholder is a valid type given the current documentation.

Expected Results:
UIActivityViewController displays the correct list of available activities if instantiated with an activity item whose -[UIActivityItemProvider initWithPlaceholderItem:] took a placeholder item that itself conforms to UIActivityItemSource.

Actual Results:
A UIActivityViewController created with an UIActivityItemProvider using a placeholder with a type that conforms to UIActivityItemSource makes the controller show an empty list of available activities.

Version:
12 beta 7
