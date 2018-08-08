//
//  ViewController.m
//  TableViewHeaders
//
//  Created by Oscar Swanros on 7/30/18.
//  Copyright © 2018 Oscar Swanros. All rights reserved.
//

#import "ViewController.h"

@interface Model : NSObject
@property (nonatomic, copy) NSString *footer;
@end

@implementation Model
@end

@interface ViewController ()
@property (nonatomic, strong) NSArray<Model *> *sections;
@end

@implementation ViewController

- (void)loadView {
    // Creating the table view with UITableViewStylePlain shows the correct behavior.
    //self.tableView = [[UITableView alloc] initWithFrame:UIScreen.mainScreen.bounds style:UITableViewStylePlain];
    self.tableView = [[UITableView alloc] initWithFrame:UIScreen.mainScreen.bounds style:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *sc = [NSMutableArray new];

    for (int i = 0; i < 20; i++) {
        Model *m = [[Model alloc] init];
        m.footer = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
        [sc addObject:m];
    }
    _sections = [sc copy];

    [self.tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"Cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.item];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Title %ld", section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return _sections[section].footer;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

@end
