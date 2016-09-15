//
//  MasterViewController.h
//  Restore
//
//  Created by Daniel on 11.02.15.
//  Copyright (c) 2015 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end

