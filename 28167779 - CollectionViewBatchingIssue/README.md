## UICollectionView performBatchUpdates can trigger a crash if the collection view is flagged for layout

http://openradar.appspot.com/28167779

Summary:

Using `-[UICollectionView performBatchUpdates:completion:]` can in some cases trigger an assertion (`NSInternalInconsistencyException`) due to the data source being queried for the updated item counts too quickly. 

As per `UICollectionView` programming guide, we should first update the model and then do any incremental collection view updates. If we follow this guideline and the collection view is in a certain state (needing layout?), the `UICollectionViewData` source methods are called immediately when the `performBatchUpdates` call is reached. This updates the internal state, which causes the incremental updates to be applied on an already up-to-date state.

```
items.append("three")

collectionView.performBatchUpdates({
    collectionView.insertItems(at: [NSIndexPath(item: 2, section: 0) as IndexPath])
}, completion: nil)
```

Steps to Reproduce:

If Swift hasn’t been rewritten in the meantime, just build and run the attached sample. The application should crash after a few seconds. 
All the relevant example code is in `ViewController.swift`. 

Expected Results:

The incremental updates would be performed without any issues. 

Actual Results:

An exception is thrown because the item counts get updated before the incremental updates are applied. 

```
2016-09-06 10:29:55.833 CollectionViewBatchingIssue[1586:213220] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Invalid update: invalid number of items in section 0.  The number of items contained in an existing section after the update (3) must be equal to the number of items contained in that section before the update (3), plus or minus the number of items inserted or deleted from that section (1 inserted, 0 deleted) and plus or minus the number of items moved into or out of that section (0 moved in, 0 moved out).'
*** First throw call stack:
(
	0   CoreFoundation                      0x000000010f57fd85 __exceptionPreprocess + 165
	1   libobjc.A.dylib                     0x000000010cc2edeb objc_exception_throw + 48
	2   CoreFoundation                      0x000000010f57fbea +[NSException raise:format:arguments:] + 106
	3   Foundation                          0x000000010c878d5a -[NSAssertionHandler handleFailureInMethod:object:file:lineNumber:description:] + 198
	4   UIKit                               0x000000010d922077 -[UICollectionView _endItemAnimationsWithInvalidationContext:tentativelyForReordering:] + 15363
	5   UIKit                               0x000000010d929497 -[UICollectionView _performBatchUpdates:completion:invalidationContext:tentativelyForReordering:] + 415
	6   UIKit                               0x000000010d9292d5 -[UICollectionView _performBatchUpdates:completion:invalidationContext:] + 74
	7   UIKit                               0x000000010d929278 -[UICollectionView performBatchUpdates:completion:] + 53
	8   CollectionViewBatchingIssue         0x000000010c71af68 _TFC27CollectionViewBatchingIssue14ViewControllerP33_AD2F90D15FF8949970866ECEAB23D08711updateItemsfT_T_ + 1048
	9   CollectionViewBatchingIssue         0x000000010c71a865 _TFFC27CollectionViewBatchingIssue14ViewController13viewDidAppearFSbT_U_FT_T_ + 21
	10  CollectionViewBatchingIssue         0x000000010c71a957 _TTRXFo___XFdCb___ + 39
	11  libdispatch.dylib                   0x000000011018cd9d _dispatch_call_block_and_release + 12
	12  libdispatch.dylib                   0x00000001101ad3eb _dispatch_client_callout + 8
	13  libdispatch.dylib                   0x0000000110192686 _dispatch_after_timer_callback + 334
	14  libdispatch.dylib                   0x00000001101ad3eb _dispatch_client_callout + 8
	15  libdispatch.dylib                   0x00000001101a07e5 _dispatch_source_latch_and_call + 1750
	16  libdispatch.dylib                   0x000000011019b770 _dispatch_source_invoke + 1057
	17  libdispatch.dylib                   0x0000000110195051 _dispatch_main_queue_callback_4CF + 1324
	18  CoreFoundation                      0x000000010f4d90f9 __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ + 9
	19  CoreFoundation                      0x000000010f49ab99 __CFRunLoopRun + 2073
	20  CoreFoundation                      0x000000010f49a0f8 CFRunLoopRunSpecific + 488
	21  GraphicsServices                    0x0000000111287ad2 GSEventRunModal + 161
	22  UIKit                               0x000000010d093f09 UIApplicationMain + 171
	23  CollectionViewBatchingIssue         0x000000010c71c84f main + 111
	24  libdyld.dylib                       0x00000001101e192d start + 1
	25  ???                                 0x0000000000000001 0x0 + 1
)
```

Regression:

Tested on iOS 9 and iOS 10. Happens on both versions. 

Commenting out the dummy `collectionView.reloadData()` causes the collection view to use a different code path that doesn’t trigger the issue. This reload data call here might look pretty artificial in the example, but in a complex application it might very well happen. 

The issue also doesn’t happen if the model is updated inside the `performBatchUpdates` block. I could not find any documentation requiring this and it would also very cumbersome to do in our case where the data source update happens in a different object. 

There are reports out there of this happening in other cases as well. http://stackoverflow.com/q/26898835/88854

Notes:

Stack trace leading from the `performBatchUpdates` call to the data source methods being triggered. 

```
* thread #1: tid = 0x35d28, 0x000000010ebfe1ab CollectionViewBatchingIssue`ViewController.collectionView(collectionView=0x00007f9ce301f800, section=0, self=0x00007f9ce280c530) -> Int + 27 at ViewController.swift:57, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x000000010ebfe1ab CollectionViewBatchingIssue`ViewController.collectionView(collectionView=0x00007f9ce301f800, section=0, self=0x00007f9ce280c530) -> Int + 27 at ViewController.swift:57
    frame #1: 0x000000010ebfe232 CollectionViewBatchingIssue`@objc ViewController.collectionView(UICollectionView, numberOfItemsInSection : Int) -> Int + 66 at ViewController.swift:0
    frame #2: 0x000000010fe4856c UIKit`-[UICollectionViewData _updateItemCounts] + 492
    frame #3: 0x000000010fe4b009 UIKit`-[UICollectionViewData numberOfSections] + 22
    frame #4: 0x000000010fe2cf51 UIKit`-[UICollectionViewFlowLayout _getSizingInfos] + 445
    frame #5: 0x000000010fe2ec47 UIKit`-[UICollectionViewFlowLayout _fetchItemsInfoForRect:] + 118
    frame #6: 0x000000010fe283fd UIKit`-[UICollectionViewFlowLayout prepareLayout] + 273
    frame #7: 0x000000010fe48c3d UIKit`-[UICollectionViewData _prepareToLoadData] + 67
    frame #8: 0x000000010fe49411 UIKit`-[UICollectionViewData validateLayoutInRect:] + 53
    frame #9: 0x000000010fdf653a UIKit`-[UICollectionView layoutSubviews] + 199
    frame #10: 0x000000010f631980 UIKit`-[UIView(CALayerDelegate) layoutSublayersOfLayer:] + 703
    frame #11: 0x0000000114382c00 QuartzCore`-[CALayer layoutSublayers] + 146
    frame #12: 0x000000011437708e QuartzCore`CA::Layer::layout_if_needed(CA::Transaction*) + 366
    frame #13: 0x000000010f621205 UIKit`-[UIView(Hierarchy) layoutBelowIfNeeded] + 1129
    frame #14: 0x000000010fe0c3e9 UIKit`-[UICollectionView _performBatchUpdates:completion:invalidationContext:tentativelyForReordering:] + 241
    frame #15: 0x000000010fe0c2d5 UIKit`-[UICollectionView _performBatchUpdates:completion:invalidationContext:] + 74
    frame #16: 0x000000010fe0c278 UIKit`-[UICollectionView performBatchUpdates:completion:] + 53
  * frame #17: 0x000000010ebfdf68 CollectionViewBatchingIssue`ViewController.updateItems(self=0x00007f9ce280c530) -> () + 1048 at ViewController.swift:51
    frame #18: 0x000000010ebfd865 CollectionViewBatchingIssue`ViewController.(self=0x00007f9ce280c530) -> ()).(closure #1) + 21 at ViewController.swift:20
    frame #19: 0x000000010ebfd957 CollectionViewBatchingIssue`thunk + 39 at ViewController.swift:0
    frame #20: 0x000000011266fd9d libdispatch.dylib`_dispatch_call_block_and_release + 12
    frame #21: 0x00000001126903eb libdispatch.dylib`_dispatch_client_callout + 8
    frame #22: 0x0000000112675686 libdispatch.dylib`_dispatch_after_timer_callback + 334
    frame #23: 0x00000001126903eb libdispatch.dylib`_dispatch_client_callout + 8
    frame #24: 0x00000001126837e5 libdispatch.dylib`_dispatch_source_latch_and_call + 1750
    frame #25: 0x000000011267e770 libdispatch.dylib`_dispatch_source_invoke + 1057
    frame #26: 0x0000000112678051 libdispatch.dylib`_dispatch_main_queue_callback_4CF + 1324
    frame #27: 0x00000001119bc0f9 CoreFoundation`__CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ + 9
    frame #28: 0x000000011197db99 CoreFoundation`__CFRunLoopRun + 2073
    frame #29: 0x000000011197d0f8 CoreFoundation`CFRunLoopRunSpecific + 488
    frame #30: 0x000000011376aad2 GraphicsServices`GSEventRunModal + 161
    frame #31: 0x000000010f576f09 UIKit`UIApplicationMain + 171
    frame #32: 0x000000010ebff84f CollectionViewBatchingIssue`main + 111 at AppDelegate.swift:12
    frame #33: 0x00000001126c492d libdyld.dylib`start + 1
```
