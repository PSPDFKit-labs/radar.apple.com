## 30043880 - SimpleCollectionViewLayout

Summary:
When implementing a custom collection view layout and invalidating this layout, the collection view calls `-layoutAttributesForElementsInRect:` and after that calls `-prepareLayout`. According to the documentation: “During each layout update, the collection view calls this method first to give your layout object a chance to prepare for the upcoming layout operation.” this should actually be the other way around. The collection view should first let the layout know that it should `-prepareLayout` which would then update the layout to the new truth, and after that, the collection view should ask for this new layout e.g. by calling `-layoutAttributesForElementsInRect:`.

Steps to Reproduce:
- Open the attached sample
- Run this sample in an iPad Air 2 Simulator that launches the app in portrait orientation
- After the initial layout is done, clear the console in Xcode (there are shared breakpoints in the project that log what is called in which order)
- Rotate the device
- Have a look at the console output

Expected Results:
- The layout should adopt the the new width of the view controller
- Console should contain this:
-invalidateLayoutWithContext: 100 indexes
-prepareLayout
-layoutAttributesForElementsInRect: (origin = (x = 0, y = 0), size = (width = 1024, height = 1024))

Actual Results:
- The layout did not update properly
- Console actually contains this:
-invalidateLayoutWithContext: 100 indexes
-layoutAttributesForElementsInRect: (origin = (x = 0, y = 0), size = (width = 1024, height = 1024))
-prepareLayout

Regression:


Notes:
- I tried to make the layout in the sample as small and easy to understand as possible.
- If you launch the app in landscape and rotate to portrait instead, you will see another layout issue where only part of the items updated
