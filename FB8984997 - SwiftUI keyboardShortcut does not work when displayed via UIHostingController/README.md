# FB8795412: SwiftUI keyboardShortcut does not work when displayed via UIHostingController

SwiftUI keyboardShortcut does not work when displayed via `UIHostingController`. The only way I can make it work is if I opt into SwiftUI app lifecycle, which new can’t because iOS 13 and missing features.

Interestingly enough the code works in Catalyst.

Discussed this on Twitter: https://twitter.com/steipete/status/1355545569457016836?s=21

Blog Post with further details: https://steipete.com/posts/fixing-keyboardshortcut-in-swiftui/