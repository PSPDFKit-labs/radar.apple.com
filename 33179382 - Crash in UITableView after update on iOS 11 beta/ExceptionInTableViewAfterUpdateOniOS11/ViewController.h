//
//  ViewController.h
//  ExceptionInTableViewAfterUpdateOniOS11
//
//  Created by Konstantin Bender on 07.07.17.
//  Copyright © 2017 Konstantin Bender. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)toggleEdit:(id)sender;

@end

