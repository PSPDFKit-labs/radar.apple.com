## Mac Catalyst: Setting an image for a system menu entry does not work. This is needed to replicate the "Open Recent" menu.

FB7316225

Please provide a descriptive title for your feedback:
Mac Catalyst: Setting an image for a system menu entry does not work. This is needed to replicate the "Open Recent" menu.

Which area are you seeing an issue with?
UIKit

What type of feedback are you reporting?
Incorrect/Unexpected Behavior

Description
UICommand includes an image property to add an image to a menu item:

let command = UICommand(title: documentURL.lastPathComponent, action:#selector(ViewController.loadLastRecentFile))
command.image = UIImage(systemName: "paperplane.fill")
recents.append(command)
 let openRecentMenu = UIMenu(title: "Open Recent", identifier: UIMenu.Identifier("open_recent"), options: [], children: recents)

However, this setting seems to be ignored and does not work.
We need this to replicate the “Open Recent” menu that other Mac apps offer.

See attached example project for a failing project. This uses UIImage(systemName: "paperplane.fill”), however we also tried other ways to load images - did not work either.

Instructions: Open an image via the button “Open URL” then observe that the menu adds this entry to the File -> Open Recent list. However there is no image next to it.
Observe that Preview does add images there. We need to offer the same functionality to the user.
