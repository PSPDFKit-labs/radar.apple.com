//
//  TableViewCell.h
//  EditingCrashExample
//
//  Created by Konstantin Bender on 5/30/17.
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableViewCell;

@interface TableViewCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
