//
//  PSPDFSectionModel.h
//  UITableView-UITableViewAutomaticDimension
//
//  Created by Marcin Krzyzanowski on 08/06/2018.
//  Copyright © 2018 Marcin Krzyzanowski. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PSPDFStaticTableViewController, PSPDFCellModel;

/// Defines the content for a section in `UITableView`.
@interface PSPDFSectionModel : NSObject

+ (instancetype)sectionWithTitle:(nullable NSString *)headerTitle cells:(nullable NSArray<__kindof PSPDFCellModel *> *)cells;

@property (nonatomic, copy, nullable) NSString *headerTitle;
@property (nonatomic, copy, nullable) NSString *footerTitle;
@property (nonatomic, nullable) UIView *headerView;
@property (nonatomic, nullable) UIView *footerView;

/// Reading this will include `editingCellModels`.
@property (nonatomic, copy, nullable) NSArray<__kindof PSPDFCellModel *> *cells;

/// Invoke to update the section model.
@property (nonatomic, copy, nullable) void (^updateBlock)(__kindof PSPDFStaticTableViewController *viewController, __kindof PSPDFSectionModel *sectionModel);

/// Calls `updateBlock` if it exists.
- (void)updateWithViewController:(PSPDFStaticTableViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
