## Using URLByResolvingBookmarkData to access files outside the sandbox, that previously were selected via UIDocumentPickerViewController does not work.

FB7316177

Please provide a descriptive title for your feedback:
Using URLByResolvingBookmarkData to access files outside the sandbox, that previously were selected via UIDocumentPickerViewController does not work.

Which area are you seeing an issue with?
Foundation

What type of feedback are you reporting?
Incorrect/Unexpected Behavior

Description
Please describe the issue and what steps we can take to reproduce it:
This bug affects both iOS and Mac Catalyst.
We use UIDocumentPickerViewController (or UIDocumentBrowserViewController) to get access to user files.
To build a menu for recently opened documents in Mac , we store these NSURL files as bookmarks in user defaults.
However, after an app restart we lack permission to load these URLs again. Based on documentation, this should work and we do the right thing:

NSData *bookmarkData = [self bookmarkDataWithOptions:NSURLBookmarkCreationSuitableForBookmarkFile includingResourceValuesForKeys:nil relativeToURL:nil error:&error];
// later
NSURL *url = [NSURL URLByResolvingBookmarkData:(NSData *)data options:NSURLBookmarkResolutionWithoutUI relativeToURL:nil bookmarkDataIsStale:NULL error:&error];

See the example app for details. It offers to open an image, stores this image as bookmark in the user defaults, and loads + tries to load the last selected image again on app restart. This fails both on iOS and Mac Catalyst. This is critical for us in order to build a “Opened Recently” menu.

We correctly call startAccessingSecurityScopedResource(). I tried both NSURLBookmarkResolutionWithoutUI and 0 to potentially get an alert - always results in the same issue. If we disable sandboxing on Mac Catalyst, it does work, however then we cannot submit into the Mac App Store nor distribute our app.

Any workaround is greatly appreciated.
