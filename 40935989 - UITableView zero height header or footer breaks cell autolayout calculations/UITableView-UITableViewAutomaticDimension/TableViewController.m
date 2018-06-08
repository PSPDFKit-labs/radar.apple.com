//
//  ViewController.m
//  UITableView-UITableViewAutomaticDimension
//
//  Created by Marcin Krzyzanowski on 08/06/2018.
//  Copyright © 2018 Marcin Krzyzanowski. All rights reserved.
//

#define let const __auto_type

#import "TableViewController.h"
#import "LabelValueCell.h"

static const CGFloat PSPDFMinimumRowHeight = 44.f;

@interface TableViewController ()

@end

@implementation TableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithStyle:style])) {
//        self.automaticallyResizesPopover = YES;
//        self.minimumHeightForAutomaticallyResizingPopover = 0.f;
//        self.separatorHidingMode = !PSPDFIsiPad() ? PSPDFSeparatorHidingModeAfterLastCell : PSPDFSeparatorHidingModeNone;
//        _cellCache = [NSMapTable weakToWeakObjectsMapTable];
//        _style = style;

        // Ensure sections is never nil but do not override
//        _sections = _sections ?: @[];

//        self.useZeroHeightForEmptyHeadersAndFooters = (style == UITableViewStylePlain);
        [self reloadDataIfViewLoaded];
    }
    return self;
}

- (void)loadView {
    let frame = UIScreen.mainScreen.bounds;
    let tableView = [[UITableView alloc] initWithFrame:frame];
    tableView.dataSource = self;
    tableView.delegate = self;

    if (@available(iOS 11.0, *)) {} else {
        tableView.estimatedRowHeight = PSPDFMinimumRowHeight;
        tableView.estimatedSectionHeaderHeight = 44.0;
        tableView.estimatedSectionFooterHeight = 44.0;
    }

    self.view = tableView;
    self.tableView = tableView;
}

- (void)recalculateContentSize {
    // We need to trigger _updateContentSize directly. UITableView would do that after the animation is done,
    // which would lead to an ugly two-step animation. There are certain ways to trigger updating the content size,
    // here we use the fact that settign the header view will trigger the update.
    self.tableView.tableHeaderView = self.tableView.tableHeaderView;
}

- (void)reloadDataIfViewLoaded {
    if (self.isViewLoaded) {
        [self.tableView reloadData];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Table view data source/delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    // return tableView.sectionHeaderHeight;
    // FIXME: the cell layout calculations are invalid when return 0.
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // return tableView.sectionFooterHeight;
    // FIXME: the cell layout calculations are invalid when return 0.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    let model = [self cellModelForIndexPath:indexPath];

    // Because the model's `createBlock` often does things that would need explicit teardown (e.g. `-addTarget:action:`)
    // we don't reuse cells for different models like with a normal table view. This is acceptable because the only
    // times we use `PSPDFStaticTableViewController` is when we have a manageable amount of cells (~10).
    //
    // In order to not expose this implementation detail to `PSPDFCellModel` (which should be usable with conventional
    // `UITableView`s too, even though at the time of writing this note it wasn't) we can't simply create a new
    // `@property cell` on `PSPDFCellModel`, so instead we use a weakToWeak `NSMapTable`.
//    var cell = [self.cellCache objectForKey:model];
//    if (!cell) {
        let cell = [[LabelValueCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
//        if (model.createBlock) {
//            model.createBlock(self, cell);
              cell.titleLabel.text = @"Content Creator";
              [cell.titleLabel sizeToFit];
              cell.valueLabel.text = @"Adobe InDesign CC 2017 (Macintosh)";
              [cell.valueLabel sizeToFit];

//        }

//        [self.cellCache setObject:cell forKey:model];
//    }

    // More complex cell layouts (auto layout!) are easier with a custom titleLabel.
//    let customTitleLabelCell = PSPDFProtocolCast(cell, PSPDFCustomTitleLabelCell);
//    if (customTitleLabelCell) {
//        customTitleLabelCell.titleLabel.text = model.title;
//    } else {
//    cell.textLabel.text = nil;
//    }

//    cell.detailTextLabel.text = nil;
//    cell.detailTextLabel.numberOfLines = 1;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (tableView.estimatedRowHeight == UITableViewAutomaticDimension || tableView.estimatedRowHeight == PSPDFMinimumRowHeight) {
        let minimumRowHeight = tableView.rowHeight != -1 ? tableView.rowHeight : PSPDFMinimumRowHeight;
        let heightConstraint = [cell.contentView.heightAnchor constraintGreaterThanOrEqualToConstant:minimumRowHeight];
        heightConstraint.priority = UILayoutPriorityDefaultHigh - 1;
        heightConstraint.active = YES;
    }

    // Allow predefined accessoryViews in cell subclasses.
//    if (model.accessoryView) {
//        cell.accessoryView = model.accessoryView;
//    }

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.tableView) {
//        let model = [self cellModelForIndexPath:indexPath];
//
//        // Call update block before showing.
//        [self callUpdateBlockOnModel:model withCell:cell atIndexPath:indexPath];
        [cell setNeedsLayout];
//
//        if (model.willDisplayBlock) {
//            model.willDisplayBlock(self, cell, indexPath);
//        }
    }
}

//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (tableView == self.tableView) {
//        /// Using standard cellModelForIndexPath can fail when sections are modified. Using cellCache gives you originally assinged model.
//        let model = [self.cellCache.keyEnumerator.allObjects pspdf_objectPassingTest:^BOOL(PSPDFCellModel *cellModel) {
//            return [self.cellCache objectForKey:cellModel] == cell;
//        }];
//
//        if (model.didEndDisplayBlock) {
//            model.didEndDisplayBlock(self, cell, indexPath);
//        }
//    }
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Returning AutomaticDimension indicates auto cell sizing
//    if (tableView != self.tableView) {
//        return UITableViewAutomaticDimension;
//    }
//
//    let width = CGRectGetWidth(tableView.bounds);
//    let cellDefinition = [self cellModelForIndexPath:indexPath];
//
//    // Block takes precedence over default implementation.
//    if (cellDefinition.heightBlock) {
//        return cellDefinition.heightBlock(self, width);
//    } else {
//        return cellDefinition.height;
//    }
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (tableView != self.tableView) {
//        return;
//    }
//
//    let cellDefinition = [self cellModelForIndexPath:indexPath];
//    let cell = [self.tableView cellForRowAtIndexPath:indexPath];
//
//    // Call the action block, if defined.
//    if (cellDefinition.actionBlock) {
//        cellDefinition.actionBlock(self, cell);
//    }
//
//    [self updateEditableStateForModel:cellDefinition indexPath:indexPath];
//}

//- (void)updateEditableStateForModel:(PSPDFCellModel *)cellDefinition indexPath:(NSIndexPath *)indexPath {
//    if (self.stopEditingOnCellSelectionChange && cellDefinition.isEditing == NO) {
//        let indexPaths = [NSMutableArray<NSIndexPath *> array];
//        [self.sections enumerateObjectsUsingBlock:^(PSPDFSectionModel *obj, NSUInteger section, BOOL *_) {
//            let cellModels = obj.cells;
//            for (NSUInteger row = 0; row < cellModels.count; row++) {
//                let cellModel = cellModels[row];
//                if (cellModel.isEditing) {
//                    let editingCellModels = cellModel.editingCellModels;
//                    cellModel.editing = NO;
//                    if (cellModel.editingBlock) {
//                        let editCellIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
//                        let editCell = [self.tableView cellForRowAtIndexPath:editCellIndexPath];
//                        cellModel.editingBlock(self, editCell, editCellIndexPath);
//                    }
//                    for (NSUInteger editRow = row + 1; editRow < row + editingCellModels.count + 1; editRow++) {
//                        let editIndexPath = [NSIndexPath indexPathForRow:editRow inSection:section];
//                        [indexPaths addObject:editIndexPath];
//                    }
//                    row += editingCellModels.count;
//                }
//            }
//        }];
//        if (indexPaths.count > 0) {
//            [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
//        }
//    }
//
//    // show/hide editing cells.
//    if (cellDefinition.editingCellModels.count > 0) {
//        // Add or remove cells.
//        let indexPaths = [NSMutableArray<NSIndexPath *> array];
//        [cellDefinition.editingCellModels enumerateObjectsUsingBlock:^(PSPDFCellModel *inlineCellModel, NSUInteger idx, BOOL *_) {
//            inlineCellModel.parentModel = cellDefinition;
//            [indexPaths addObject:[NSIndexPath indexPathForRow:indexPath.row + idx + 1 inSection:indexPath.section]];
//        }];
//
//        [self.tableView beginUpdates];
//        if (cellDefinition.isEditing) {
//            [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
//        } else {
//            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
//        }
//        cellDefinition.editing = !cellDefinition.isEditing;
//        if (cellDefinition.editingBlock) {
//            let cell = [self.tableView cellForRowAtIndexPath:indexPath];
//            cellDefinition.editingBlock(self, cell, indexPath);
//        }
//        [self.tableView endUpdates];
//        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//        [self recalculateContentSize];
//
//        // Update all cells to allow them to adapt to isEditing changes.
//        [self updateVisibleCells];
//
//        if (!self.pspdf_isInPopoverPresentation) {
//            // Scroll to inserted cell when editing and to current cell otherwise
//            let visibleIndex = cellDefinition.editing ? indexPaths.lastObject : indexPath;
//            if (visibleIndex) {
//                [self.tableView scrollToRowAtIndexPath:visibleIndex atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//            }
//        }
//    }
//}

//- (void)callUpdateBlockOnModel:(PSPDFCellModel *)cellModel withCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//
//    // When we edit, we do not want a line separator
//    if (cellModel.isEditing) {
//        // Trick to hide the separator by forcing a width of 0.
//        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, CGRectGetWidth(cell.bounds));
//    } else {
//        cell.separatorInset = UIEdgeInsetsZero;
//    }
//
//    if (cellModel.updateBlock) {
//        cellModel.updateBlock(self, cell, indexPath);
//    }
//
//    [cell setNeedsLayout];
//}


@end
