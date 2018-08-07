Summary:
Files.app fails to correctly handle drops from other applications if at least one of the items being dropped wasn't created with an `NSItemProvider` with a registered file type. I don't think this is specifically an app-level issue, but rather an API limitation one.

In the source app, within the context of `UICollectionView`, if the drag delegate methods return a list of `UIDragItem`s, but at least one of them was created with an "empty" `NSItemProvider`:

```
- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForAddingToDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point {
    return @[[[UIDragItem alloc] initWithItemProvider:[NSItemProvider new]]];
}
```

and a drop is attempted in Files.app, none of the valid drag items in the session will be dropped either, effectively behaving as if the drop operation was `UIDropOperationCancel`.

Photos.app does not behave like this. If one of the providers associated with the dropping drag items is not available to provide information about the item being dropped, Photos.app will still import the "valid" items and display a message "Some Items Not Imported", which is IMO a nice compromise (way better than cancelling the whole drop operation altogether).

I believe a way for the source application to play a role in how the destination application handles drops could be really useful, if not by providing a fallback in case the drop can't be performed for any reason (i.e., an "empty" item provider), at least by allowing it to determine wether a message should be shown to the user or not/customize it.

We ran into this while trying to work around rdar://41790438. Returning a `UIDragItem` with an empty `NSItemProvider` makes the collection view lift the item, making it appear as valid. However, the "validity" of the item is delegated to the destination application, making it effectively impossible to foresee what the result will be if the drop location can't handle at least one of the items in the drag session.

Our very specific use case would be to effectively allow our application to export a single file from a multiple-item drag session drop, by returning (valid) drag items with "empty" item providers and doing bookkeeping internally of the index paths to export. Then, Files.app would let our application try to fix the drop session somehow when it determined that a drag item does not contain a valid item provider.



Steps to Reproduce:
1. Download the attached project and run side-by-side with Photos.app.
2. Start a drag session from the sample app, and add two or more items to it.
3. Drop the dog pictures in Photos.app. Notice how only one photos is imported and a "Some Items Not Imported" is displayed.
4. Now open Files.app side-by-side with the sample application.
5. Start a drag session from the sample app, and add two or more items to it.
6. Attempt to drop the items into a Files.app folder. Notice how there's no import error message, and the drop just plainly fails.

Expected Results:
Ideally, the API would allow the source application play a role in the dropping operation for the destination application so that both applications can coordinate about the correct result for a specific drop attempt.

Actual Results:
There's no visibility for the source application into wether the exported data is handled correctly, thus hampering our ability to provide a good user experience when offering Drag and Drop features.

Version:
11.4

Notes:
I'm aware that this is a super-specific, super obscure enhancement request, but I do think that the iOS ecosystem could benefit greatly from improved, more flexible, Drag and Drop APIs.