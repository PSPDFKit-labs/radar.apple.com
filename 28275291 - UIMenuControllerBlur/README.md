## UIMenuController is leaking out blur background. Discussed at WWDC 2016. Hard to reproduce. Always sticks in the eye.

http://openradar.appspot.com/28275291

Area:
UIKit

Summary:
UIMenuController sometimes has a bug where the mask on the blur background is cleared, making it look like the blur "leaks out" of the shape, which looks quite silly. This has been reported to us numerous times, and I always (wrongfully) assumed that this must be widespread and surely will be fixed. It was extremely hard to figure out how to trigger this reproducibly.

It's been bugging us in PSPDFKit since iOS 7 but without a clear way to repro, we dismissed it as "sometimes" and "random bug" and largely ignored the ticket.

It really popped up again because we're finally doing this PDF Viewer app (yay!) and quite a few people reported this bug again. So - finally spent time on it. I know, timing for iOS 10 is a but unfortunate, but since this seems to be a purely visual bug you might be able to fix it without the AppCompat team shouting at you.

We did discuss this in the UIKit labs at WWDC 2016 but didn't get much interest from the maintainer of this component to fix - potentially because you were swamped with other issues. Well - here I am again, trying once more :)

Steps to Reproduce:
Download our PDF Viewer app: pspdfkit.com/viewer

select text
set any annotation via the toolbar
select the annotation again
"Type.." to change the annotation so something different
Now the toolbar is not transparent or has weird shadows
Sometimes the shadow is noticable, but sometimes it's just one corner that is not transparent

Alternatively - you can also download a demo of PSPDFKit (attaching latest stable here), open the PSPDFCatalog, select a PDF (e.g. just choose first entry) and the follow the steps above. The flow is the same.

I'm trying to come up with an isolated example, but so far did not succeed.

See the flow.gif for a visual walk-through. Also notice how the animation seems broken once the blur leaks out.

Expected Results:
The blur background should stay behind the shape to keep a consistent UI component.

Actual Results:
The blur background loses its mask and the control looks weird - see screenshot.

Version:
iOS 10 GM

Notes:
This is in the codebase since iOS 7.

Configuration:
iPhone 6s Plus (but really, any device is affected also Simulator)
