//
//  PSPDFSectionModel.m
//  UITableView-UITableViewAutomaticDimension
//
//  Created by Marcin Krzyzanowski on 08/06/2018.
//  Copyright © 2018 Marcin Krzyzanowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSPDFSectionModel.h"

@implementation PSPDFSectionModel {
    BOOL _isInUpdateBlock : 1;
}

@synthesize cells = _cells;

+ (instancetype)sectionWithTitle:(nullable NSString *)headerTitle cells:(nullable NSArray<__kindof PSPDFCellModel *> *)cells {
    PSPDFSectionModel *section = [self new];
    section.headerTitle = headerTitle;
    section.cells = cells;
    return section;
}

- (void)setCells:(NSArray<PSPDFCellModel *> *)cells {
    [_cells makeObjectsPerformSelector:@selector(setSection:) withObject:nil];
    _cells = [cells copy];
    [cells makeObjectsPerformSelector:@selector(setSection:) withObject:self];
}

- (NSArray<PSPDFCellModel *> *)cells {
    return [_cells pspdf_flatMap:^NSArray *(PSPDFCellModel *model) {
        return model.isEditing ? [@[model] arrayByAddingObjectsFromArray:model.editingCellModels] : @[model];
    }];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, cells: #%tu>", self.class, (void *)self, self.cells.count];
}

- (void)updateWithViewController:(PSPDFStaticTableViewController *)viewController {
    // Prevent recursive update block calling.
    if (_isInUpdateBlock) {
        return;
    }

    _isInUpdateBlock = YES;
    if (self.updateBlock) {
        self.updateBlock(viewController, self);
    }
    _isInUpdateBlock = NO;
}

@end
