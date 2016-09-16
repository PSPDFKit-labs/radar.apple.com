## Customize layout of UICollectionViewFlowLayout's last row.

http://openradar.appspot.com/20825965

Summary:
UICollectionViewFlowLayout's last row is left-aligned by default if items have a non-uniform height, when many use cases would expect a justified positioning. This can be customized using private API, but is not public.

Steps to Reproduce:
Open example. Observe this: http://cl.ly/image/0F3f2P453X2W
Expected/Wanted: http://cl.ly/image/2K330W304021

Expected Results:
Last line layout should be justified.

Actual Results:
Last line layout is not justified.

Regression:
This is the case since iOS 6.

Notes:
I discovered this back then when I wrote PSTCollectionView. A horrible, private API workaround is this:

    NSMutableDictionary *rowAlignmentOptions = [NSMutableDictionary dictionaryWithDictionary:[flowLayout valueForKey:@"rowAlignmentOptions"]];
    rowAlignmentOptions[@"UIFlowLayoutLastRowHorizontalAlignmentKey"] = rowAlignmentOptions[@"UIFlowLayoutCommonRowHorizontalAlignmentKey"];
    flowLayout setValue:rowAlignmentOptions forKey:@"rowAlignmentsOptions"];

It’s unexpected that lay-outing changes as soon as one size has a non-uniform height, which I assume has to do with an internal optimization that calculates the frames faster for uniform-sized elements.

Tested on iOS 10 GM, still broken.
