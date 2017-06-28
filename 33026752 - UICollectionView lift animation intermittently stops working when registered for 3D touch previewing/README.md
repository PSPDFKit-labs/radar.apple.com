Summary:
When the collection view is set up to use drag and drop, and also registered as the source view for 3D touch previewing, the lift animation on the cells stops working correctly if the cell overrides the contentView with a custom view.

This method is mentioned in Session 232 from WWDC 2014: https://developer.apple.com/videos/play/wwdc2014/232/ and might simply be outdated.
The sample (at https://developer.apple.com/sample-code/wwdc/2015/downloads/Advanced-Collection-View.zip) provides a collection view cell that overrides -contentView with an internal view (in AAPLCollectionViewCell.m:570).


Steps to Reproduce:
1. Run the CollectionViewLift sample on an iPad running iOS 11 (device or simulator)
2. Press and hold on any cell. Not that the lift animation works fine.
3. Drag the cell to start a new drag session.Release the cell.
4. Press and hold on another cell. Not that there is no lift animation. Release the cell.



Expected Results:
In step 4, there should be a lift animation on the cell, and the drag session should begin once you start dragging.

Actual Results:
There is no lift animation, the drag session does not begin

Version:
11.0b2

Notes:
In our app that leveraged the custom content view method, we actually were able to get the drag session to start after dragging, without the lift animation. However, in this sample the drag doesn’t even begin if the lift does not work.
