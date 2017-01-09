Photos.app advertises live photo to action extensions which then can't be accessed

Summary:
When using the Photos.app to share a Live Photo to an Action Extension, the extension system tells the extension that a live photo is there but it then can't be accessed.

Steps to Reproduce:
- Install the sample project on an actual device / run the ImageSharing target on that device
- Go to Photos.app
- Open a Live Photo
- Tap the action button
- Tap the ImageSharing action extension

Expected Results:
The image is shown in the appearing view controller from the action extension.

Actual Results:
An error is shown, telling you that the item received was (null)

Regression:
The issue here is that `[itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeLivePhoto]` returns `YES` but `loadItemForTypeIdentifier:(NSString *)kUTTypeLivePhoto options:nil completionHandler:...` calls the completion handler with a nil item.

Notes:
