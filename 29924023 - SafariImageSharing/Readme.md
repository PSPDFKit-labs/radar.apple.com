Safari.app shares images as NSData instead of file URLs

Summary:
When using the Safari.app to send an image to an Action Extension, the extension receives the image itself as NSData instead of a file URL (like Photos or Messages does it).

Steps to Reproduce:
- Install the sample project on an actual device / run the ImageSharing target on that device
- Go to Safari.app
- Open an image (the actual image, not contained in a website)
- Tap the action button
- Tap the ImageSharing action extension

Expected Results:
The image is shown in the appearing view controller from the action extension.

Actual Results:
An error is shown, telling you that the item received was of type _NSInlineData

Regression:
This is especially critical as the documentation tells you to make the completion handler of `loadItemForTypeIdentifier:options:completionHandler:` already specify the type you actually want. If you specify `NSURL` in there, the completion handler is called with a `nil` value for the item because the data can not be converted to a file url.

Notes:
The current way the system handles this is a mess. It's basically 'here is a pointer to an object, it's an image btw, figure our by yourself what I actually gave you!'. To me there are three possible solutions: Either the only type ever containing a file URL is the public.file-url type and things image images always contain the actual image. This is what Safari currently does and it seems to be logical to me. This has the downside that you have no idea what you are actually dealing with when an app hands you a file-url. So the other approach would be that you always get a file url, no matter what is actually shared. This seems to be what Photos and Messages are doing. And it totally makes sense as the memory footprint is low. However this is a bit troublesome because of rdar://29918507. Once this is fixed though, this would be nice. The third option is to support both. If an app shares an NSData blob, the system can easily write this to a temp directoy if the developer asks for an NSURL and if an app shares a file URL, the system could easily create a memory mapped NSData from that file if the developer asks for an NSData instance.

No matter which solution is choosen, they are all better than the current state, as you currently have no idea what you are actually dealing with.
