//
//  CollectionViewLayout.h
//  CollectionViewLayout
//
//  Created by Michael Ochs on 1/12/17.
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionViewLayoutDelegate <UICollectionViewDelegate>

@optional

/**
 Asks the delegate for an item size for a given index path and gives the option
 to update this size later on once expensive size calculations are finished.

 If you are doing expensive size calculation you can implement this method to
 immediately return an estimate size and then do your size calculation on a background
 thread. Once done with the calculation, you can pass the correct height to the
 layout by calling the completion handler. Continuous calls to the completion handler
 will be ignored and only the first call will be used to update the size of the
 item.

 @note In case the layout is in single line mode, this method will not be called.
 Instead, only the method without a completion handler will be called as
 estimated sizing is not available for this mode.

 @warning In multi line mode layouts (i.e. singleLineMode returns `NO`), this method
 takes precedence over `collectionView:layout:itemSizeAtIndexPath:`.

 @param collectionView    The collection view object displaying the item.
 @param layout            The collection view layout used for positioning the item.
 @param indexPath         The index path of the item.
 @param completionHandler A completion handler than can optionally be called if you
 need to do expensive height calculation asynchronously.
 Can be called from an arbitraty queue.

 @return The size that the item currently should be layed out with. This can be
 an estimate in case you use the completion handler.
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)layout itemSizeAtIndexPath:(NSIndexPath *)indexPath completionHandler:(void(^)(CGSize itemSize))completionHandler;

@end


@interface CollectionViewLayout : UICollectionViewLayout

@end
