## Allow a way to create a window without affecting the status bar appearance.

http://openradar.appspot.com/23677818

Sometimes having a UIWindow is essential for apps. In PSPDFKit we use custom windows rarely, but e.g. the text loupe is build as a custom window. This is by far the most convenient way, and UIKit internally uses windows for this as well.

Problem: There’s no sane way to make the UIWindow not change the status bar. In the paste we did *insane* workarounds to try to infer the correct status bar appearance, but it’s a lot of code, error prone and just impossible to match all the little details that are in there. So we went with polling the status bar appearance (setting the window to hidden, poll the appearance, set it back to visible). This was required because our status HUD is also a window and it’s quite common that behind the HUD view controller appearance takes place, which is very hard to detect. But you might agree that polling is really, really, really horrible.

The solution that UIKit internally uses, and the solution that is correct and nice, is returning NO for _canAffectStatusBarAppearance. Unfortunately, this is private, so we have to so insane, buggy hacks to try to simulate it.

It would be great if there would be a simpler solution. Sample attached that shows the problem. (Imagine the red thing is a HUD or text loupe)


Update: Still issue in iOS 9.3.2
Fixed in iOS 10
