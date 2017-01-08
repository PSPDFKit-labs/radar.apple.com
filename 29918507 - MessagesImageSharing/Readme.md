Message.app shares image file url not accessible from inside an action extension

Summary:
When using the Messages.app to send a Photo to an Action Extension, the extension receives the image itself and a file URL. The file URL however is not accessible from inside the action extension and a message is logged in the device’s console: ‘kernel SandboxViolation: PDF Actions(14392) deny(1) file-read-metadata /private/var/mobile/Library/SMS/Attachments/bd/13/12A03E5C-C12B-4797-9007-52AC16F774AC/IMG_2021.JPG’

Steps to Reproduce:
- Install the sample project on an actual device / run the ImageSharing target on that device
- Go to the Messages.app
- Tap an image from a conversation to view it in full size
- Tap the action button in the image
- Tap an ImageSharing action extension

Expected Results:
The image is shown in the appearing view controller from the action extension.

Actual Results:
An error is shown, telling you that the path of the chosen image can not be accessed.

Regression:
- This issue only occurs on an actual device, as iOS Simulator Sandboxing restrictions do not apply to the images from the messages app.

Notes:
I am aware of the fact that the Messages.app also shared the image as data blob and that this data blob can be accessed without issues. However in our actual usecase we prefere a file url over any data blob as it can be copied withouth any size constraints and without performing memory-heavy operations. If the messages app is unable to provide the image in a path that can be accessed, it should simply not share a file URL at all.
