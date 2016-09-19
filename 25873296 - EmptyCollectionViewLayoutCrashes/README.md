## UICollectionView crashes when invalidating non existing header

http://openradar.appspot.com/25873296

Summary:
When implementing a custom `UICollectionViewLayout` subclass, invalidating a header index path that previously had no header and will have no header afterwards crashes.

Steps to Reproduce:
0. Open the attached sample project
1. Run the project
2. Rotate the device

Expected Results:
Nothing happens

Actual Results:
App crashes

Regression:


Notes:
The reason for the crash is in ViewController.m:46 (I’ve simply implemented the custom layout there). The call to `invalidateSupplementaryElementsOfKind:atIndexPaths:` makes the collection view throw an exception when validating the layout.

I am aware of the fact that it may not be a good idea to invalidate stuff that has never been layouted, however I think the collection view should either handle this gracefully or at least provide a better exception message. Something similar to the well known UITableView messages, like ‘Due to invalidation a change in the header supplementary view in index path 0-0 was expected but the attributes before the update have been nil and the attributes after the update are nil’.

The problem with that crash is that it can easily happen when integrating a layout that always has a header except for when the collection view is empty.

Tested on iOS 10 GM, not fixed.
