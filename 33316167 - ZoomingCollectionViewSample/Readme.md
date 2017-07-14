## Summary:

UICollectionView offers a great way to build all sorts of custom layouts while at the same time being very memory and performance efficient by only loading the cells that are actually visible on screen.

There is one scenario where all this awesomeness goes south, though: When you need to embed a collection view in a scroll view (e.g. to be able to zoom a collection view) the collection view always loads all cells because its size is equal to the containing scroll view’s content size.

There should be support for this kind of scenario from UIKit.

## Steps to Reproduce:

0. Open the attached sample
1. Check out ViewController

## Expected Results:

The locations marked with FIXME should work the way I noted it there.

## Actual Results:

There is a quite ugly work around required to get it working which has the caveat to break flow layout as well as cell prefetching.