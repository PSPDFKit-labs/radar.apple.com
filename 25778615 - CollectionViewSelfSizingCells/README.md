## -collectionView:layout:sizeForItemAtIndexPath: should be usable with self sizing cells

http://openradar.appspot.com/25778615

Summary:
When `-[UICollectionViewDelegateFlowLayout collectionView:layout:sizeForItemAtIndexPath:]` is implemented on a delegate, that currently automatically disables self sizing table view cells and instead the layout automatically asks for the size of every single item in the collection view. This can hugely effect performance and so there are self sizing collection view cells to prevent that from happening. However there are valid use cases where it is still the delegate that nows the correct size of the item and the cell can scale to any size the delegate wants it to be.

In this cases currently the delegate needs to set the size on a custom property of the collection view cell which then uses this size to update the size inside its layout attributes when `-preferredLayoutAttributesFittingAttributes:` is called.

Instead, like `UITableView` a `UICollectionViewFlowLayout` should still make use of the estimated item size if it is set and ask its delegate only for the visible cells as soon as `estimatedItemSize` is set and `collectionView:layout:sizeForItemAtIndexPath:` is implemented as if these conditions are met, it can safely assume the correct size is expensive to create.

Steps to Reproduce:
0. Open Sample Project
1. Run it
2. See the log output. This is triggered inside the `collectionView:layout:sizeForItemAtIndexPath:` method. 

Expected Results:
The log output should only be triggered for cells that are visible.

Actual Results:
The log output is triggered for every cell.

Regression:


Notes:
Sample Code: https://github.com/PSPDFKit-labs/radar.apple.com/tree/master/25778615%20-%20CollectionViewSelfSizingCells

Tested on iOS 10 GM, not fixed.
