//
//  ViewController.m
//  DragDrop12Test
//
//  Created by Oscar Swanros on 7/10/18.
//  Copyright © 2018 Oscar Swanros. All rights reserved.
//

#import "ViewController.h"

@interface StateModel : NSObject
@property (nonatomic, assign) NSInteger itemCount;
@end

@implementation StateModel

+ (instancetype)stateWithItemCount:(NSUInteger)count {
    StateModel *m = [StateModel new];
    m.itemCount = count;

    return m;
}

@end

@interface ViewController () <UICollectionViewDropDelegate, UICollectionViewDragDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) StateModel *currentState;
@property (nonatomic, strong) StateModel *stashedState;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _currentState = [StateModel stateWithItemCount:10];
    _stashedState = [StateModel stateWithItemCount:2];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tap while dragging." style:UIBarButtonItemStyleDone target:self action:@selector(reload)];

    self.collectionView.dragDelegate = self;
    self.collectionView.dropDelegate = self;

    [self.collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"Identifier"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.currentState.itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Identifier" forIndexPath:indexPath];

    cell.contentView.backgroundColor = UIColor.redColor;

    return cell;
}

- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath {
    NSItemProvider *prov = [[NSItemProvider alloc] init];
    return @[[[UIDragItem alloc] initWithItemProvider:prov]];
}

- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForAddingToDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point {
    NSItemProvider *prov = [[NSItemProvider alloc] init];
    return @[[[UIDragItem alloc] initWithItemProvider:prov]];
}

- (UICollectionViewDropProposal *)collectionView:(UICollectionView *)collectionView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(NSIndexPath *)destinationIndexPath {
    return [[UICollectionViewDropProposal alloc] initWithDropOperation:UIDropOperationCopy intent:UICollectionViewDropIntentInsertAtDestinationIndexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(120, 120);
}

- (void)collectionView:(UICollectionView *)collectionView performDropWithCoordinator:(id<UICollectionViewDropCoordinator>)coordinator {
    [coordinator.items enumerateObjectsUsingBlock:^(id<UICollectionViewDropItem>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [coordinator dropItem:obj.dragItem toItemAtIndexPath:coordinator.destinationIndexPath];
        self.currentState.itemCount += 1;

        [self.collectionView performBatchUpdates:^{
            [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        } completion:nil];
    }];
}

- (void)reload {
    StateModel *new = self.stashedState;
    self.stashedState = self.currentState;
    self.currentState = new;

    /*
     If both the dragDelegate and dropDelegate are set on the collection view, reordering behavior is unlocked, which makes
     the drop proposal behave as if UIDropOperationMove was provided even when UIDropOperationCopy is explicitly set.

     If while in the middle of a drag session reloadSections: is called on the collection view (when the drop is behaving as Move),
     the pplication will crash with the following assertion:

     ```
     *** Assertion failure in -[_UIDataSourceUpdateMap rebasedMapFromNewBaseMap:], /BuildRoot/Library/Caches/com.apple.xbs/Sources/UIKit/UIKit-3698.54.4/_UIDataSourceUpdateMap.m:240
     2018-07-13 16:00:09.360677-0500 DragDrop12Test[535:118199] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Could not compute initial update value after shadow updates. Update: <UICollectionViewUpdateItem: 0x1c0057460> index path before update (<NSIndexPath: 0xc000000000000016> {length = 2, path = 0 - 0}) index path after update (<NSIndexPath: 0xc000000001000016> {length = 2, path = 0 - 8}) action (move), Self: <_UIDataSourceUpdateMap: 0x1c827bb00 intialSnapshot = [_UIDataSourceSnapshotter - 0x1c8222c20:(0:10)]; finalSnapshot = [_UIDataSourceSnapshotter - 0x1c8222c40:(0:10)]; updates = (
     "<UICollectionViewUpdateItem: 0x1c824abf0> index path before update (<NSIndexPath: 0xc000000000000016> {length = 2, path = 0 - 0}) index path after update (<NSIndexPath: 0xc000000001000016> {length = 2, path = 0 - 8}) action (move)"
     )>, newBaseMap: <_UIDataSourceUpdateMap: 0x1c026c340 intialSnapshot = [_UIDataSourceSnapshotter - 0x1c8222c20:(0:10)]; finalSnapshot = [_UIDataSourceSnapshotter - 0x1c0038940:(0:2)]; updates = (
     "<UICollectionViewUpdateItem: 0x1c005c6e0> index path before update (<NSIndexPath: 0x1c003a8e0> {length = 2, path = 0 - 9223372036854775807}) index path after update ((null)) action (delete)",
     "<UICollectionViewUpdateItem: 0x1c005c980> index path before update ((null)) index path after update (<NSIndexPath: 0x1c003b0c0> {length = 2, path = 0 - 9223372036854775807}) action (insert)"
     )>'
     ```
     */
    [self.collectionView performBatchUpdates:^{
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:nil];

    /*
     However, calling reloadData works fine in the middle of a drag/drop session. Regardless of the collection view state.
     */
//    [self.collectionView reloadData];
}

- (void)removeLast {
    self.currentState.itemCount -= 1;

    [self.collectionView performBatchUpdates:^{
        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
    } completion:nil];
}

@end
