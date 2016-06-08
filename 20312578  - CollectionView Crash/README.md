Summary:
UICollectionView crashes if it is used as a `[UISearchController searchResultsController]` and the first `updateSearchResultsForSearchController:` calls `[UICollectionView insertItemsAtIndexPaths:]`.

Steps to Reproduce:
Open the provided example project, run it in a simulator and click in the search-bar.

Expected Results:
No crash.

Actual Results:
90% of the time it crashes with “malloc: *** error for object 0xXXXXXXXXXXXX: incorrect checksum for freed object - object was probably modified after being freed.”. 

The rest of the time an exception is thrown:
*** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Invalid update: invalid number of items in section 0.  The number of items contained in an existing section after the update (2) must be equal to the number of items contained in that section before the update (2), plus or minus the number of items inserted or deleted from that section (2 inserted, 0 deleted) and plus or minus the number of items moved into or out of that section (0 moved in, 0 moved out).'

Regression:
I could only reproduce it on the iOS Simulator (iOS 8.1, iOS 8.2) but not on my iPhone 5 (iOS 8.2).


Still broken on iOS 9.3.2