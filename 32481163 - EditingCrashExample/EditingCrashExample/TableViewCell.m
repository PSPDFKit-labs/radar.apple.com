//
//  TableViewCell.m
//  EditingCrashExample
//
//  Created by Konstantin Bender on 5/30/17.
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.textField resignFirstResponder];
    [self.textField setEnabled:editing];
}

#pragma mark - Text Field Delegate Methods

- (void)textFieldDidEndEditing:(UITextField *)textField {
    // Steps usually triggered by this:
    // * Notify the controller about the change
    // * Controller updates data source
    // * Data source validates the title, possibly alters it and commits
    // * Controller reloads data:
    [self.tableView reloadData];
}

@end
