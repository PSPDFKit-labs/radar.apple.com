# UIScrollView only looks up to the next scroll view when forwarding touches

## Summary:

UIScrollView has the feature to forwarding touches to its containing scroll view if it reaches its bounds. This is e.g. very helpful when using a paginated scroll view and an inner scroll view for zooming the content of a page, to achieve similar looks like the Photos app.

However this does not seem to work if there is an intermediate scroll view in between those two that has scrolling disabled. The inner most scroll view does only seem to look for its closest ancestors and stop there. I think it would be great if it would check its `scrollEnabled` property and continue to look up the chain when scrolling is disabled, as the scroll view it found apparently is configured to not function as a scroll view.

## Steps to Reproduce:

0. Open the attached sample
1. Run it e.g. on an iPhone 7 simulator or device
2. Try scrolling
3. Zoom in on a page
4. While zoomed in, scroll all the way to the edge
5. Scroll again to try to switch to the next page

## Expected Results:

After step 2, scrolling should work. You should be able to paginate through the outer most scroll view.
After step 5, this still should work. The outer most scroll view should get the touch forwarded and scroll to the next page.

## Actual Results:

After step 2 everything works as expected.
After step 5 the inner most scroll view bounces, no pagination / page change occurs.

## Version:

11b5

## Notes:

I am not sure if this should be classified as bug or as enhancement, but since it is working when zoomed out, I went with bug.
The view hierarchy here might seem a bit odd. In the actual project, the intermediate scroll view is a UICollectionView which needs to be zoomable. To achieve this, the outer scroll view has zooming enabled and the collection view has scrolling disabled (and a couple of other things to make it not load all of its content).
