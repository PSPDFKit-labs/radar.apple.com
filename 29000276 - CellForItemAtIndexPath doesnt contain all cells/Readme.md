# Summary:

When asking a collection view for cellForItemAtIndexPath: it does only return cells that are visible and not all cells that are configured. This was fine before cell prefetching became a thing, as these two states basically were identical. Now however this is different.

# Steps to Reproduce:

- Open the sample app
- Scroll through the list and notice the different cell colors
- Red means `cellForItemAtIndexPath:` did not return the cell, blue means it did.

# Expected Results:

- All cells are blue

# Actual Results:

- Depending on scroll speed, most of the non-initial cells are red.

# Regression:

# Notes:

This is because in the collectionView:cellForItemAtIndexPath: delegate call I dispatch a configuration event. From what I’ve experienced, this is a pretty common approach to load data asynchronously. The issue arises when that data loads faster than the cell scrolls into the view.

I am aware of the fact that the documentation says `Returns the visible cell object at the specified index path.`, however to me this sounds like a bug. As mentioned above: Previously this was identical with everything that was configured via `collectionView:cellForItemAtIndexPath:` and due to the equal naming of these two methods they really should work hand in hand. So now that prefetching is a thing, the documentation and functionality on this should be changed to make these methods work like counterparts. `cellForItemAtIndexPath:` should return all cells that have been configured by `collectionView:cellForItemAtIndexPath:`.