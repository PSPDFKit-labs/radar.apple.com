Summary:
If both the dragDelegate and dropDelegate are set on the collection view, reordering behavior is unlocked, which makes the drop proposal behave as if UIDropOperationMove was provided even when UIDropOperationCopy is explicitly set.

If while in the middle of a drag session reloadSections: is called on the collection view (when the drop is behaving as Move), the application will crash with the following assertion:

```
*** Assertion failure in -[_UIDataSourceUpdateMap rebasedMapFromNewBaseMap:], /BuildRoot/Library/Caches/com.apple.xbs/Sources/UIKit/UIKit-3698.54.4/_UIDataSourceUpdateMap.m:240
2018-07-13 16:16:33.522899-0500 DragDrop12Test[566:125390] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Could not compute initial update value after shadow updates. Update: <UICollectionViewUpdateItem: 0x1c024f690> index path before update (<NSIndexPath: 0xc000000000000016> {length = 2, path = 0 - 0}) index path after update (<NSIndexPath: 0xc000000001200016> {length = 2, path = 0 - 9}) action (move), Self: <_UIDataSourceUpdateMap: 0x1c046d100 intialSnapshot = [_UIDataSourceSnapshotter - 0x1c0224cc0:(0:10)]; finalSnapshot = [_UIDataSourceSnapshotter - 0x1c0224ca0:(0:10)]; updates = (
    "<UICollectionViewUpdateItem: 0x1c02457f0> index path before update (<NSIndexPath: 0xc000000000000016> {length = 2, path = 0 - 0}) index path after update (<NSIndexPath: 0xc000000001200016> {length = 2, path = 0 - 9}) action (move)"
)>, newBaseMap: <_UIDataSourceUpdateMap: 0x1c046d6c0 intialSnapshot = [_UIDataSourceSnapshotter - 0x1c0224cc0:(0:10)]; finalSnapshot = [_UIDataSourceSnapshotter - 0x1c0228be0:(0:2)]; updates = (
    "<UICollectionViewUpdateItem: 0x1c024f9c0> index path before update (<NSIndexPath: 0x1c0229120> {length = 2, path = 0 - 9223372036854775807}) index path after update ((null)) action (delete)",
    "<UICollectionViewUpdateItem: 0x1c024ea90> index path before update ((null)) index path after update (<NSIndexPath: 0x1c02291a0> {length = 2, path = 0 - 9223372036854775807}) action (insert)"
)>'
```

However, calling - reloadData on the collection view works every time, regardless of the state of the drag/drop session.

NOTE:
Some times, the session will behave as Copy (lifting an item preview, but leaving the original cell in the collection view.

This behavior is not 100% reproducible, but when it happens, calling reloadSections: works just fine.

Steps to Reproduce:
- Download sample project and run on iPad.
- Start a drag session by long pressing an item on the collection view.
- When the full item lift happens and the collection view enables the drop, tap the "Tap while dragging" button on the nav bar.

Expected Results:
The collection view is refreshed correctly when calling reloadSections and doesn't crash while in the middle of a drag/drop session.

Actual Results:
The collection view crashes when reloadSections is called while in the middle of a drag/drop session.

Version:
11.4.1

Notes:
Marked as DUPLICATE OF 36021830
