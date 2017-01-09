Messages.app advertises live photos to action extensions as arbitrary image (public.image) and is sharing a jpeg.

Summary:
When using the Messages.app to share a Live Photo to an Action Extension, the extension system tells the extension that a public.image is shared. When retrieving the item as URL, a URL with the .jpg extension is handed to the extension. Messages should share the live photo and should advertise the fallback jpeg as public.jpeg.

Steps to Reproduce:
- Install the sample project on an actual device / run the ImageSharing target on that device
- Go to Messages.app
- Open a Live Photo
- Tap the action button
- Tap the ImageSharing action extension

Expected Results:
The image is shown in the appearing view controller from the action extension.

Actual Results:
An error is shown, telling you that only an arbitrary image was shared.

Regression:

Notes:
