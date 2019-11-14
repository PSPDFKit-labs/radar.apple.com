# Setup

An iOS application can modify it's LSItemContentTypes key to include a list of UTIs the
application can interact with, as a means for the system to provide this application as
a recommendation when the iOS user interacts with a file with said UTI.

If an iOS application shares an item via UIActivityViewController, and the item(s) shared
are of say, UTI com.adobe.pdf, iOS will automatically include all of the applications installed
in the system as part of the sharing sheet — these "special" activities, rather than just being
named after the source application, have names in the form of "Copy to [Application]".


# Bug

This only happens when sharing items with "explicit" UTIs, such as com.adobe.pdf, but not
for URLs, Images, or plain text.

On iOS 12 and below, tapping on any of those "Copy to [Application]" activities triggers the
following (consider this **expected behavior**):

1. The `completionWithItemsHandler` block is called.
2. The `UIActivityViewController` is dismissed.
3. The document is opened on the destination application.

At this point, the user can go back to the source application and continue working without any
trouble, picking where they left off.

However, on iOS 13, selecting an "Copy to [Application]" activity exhibits the following (consider
this **actual behavior**):

1. The `completionWithItemsHandler` block is **not** called.
2. The `UIActivityViewController` is **not** dismissed.
3. The document is openend on the destination application.

Now, when the user goes back to the source application, the `UIActivityViewController` will still
be visible, but tapping any of the available activities will yield no result: nothing will be shared
to any activity, and the user will have to manually dismiss the share sheet (which on compact size
classes is a multiple-step process).


# Why

Even when the non-dismissal of the `UIActivityViewController` is a bug by its own, more important
to us is that the `completionWithItemsHandler` is not being called since we use this to clean up
potentially sensitive artifacts that may be originated when sharing.