//
//  ViewController.m
//  SelfSizingCells
//
//  Created by Michael Ochs on 6/3/16.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.imageView.image = [UIImage imageNamed:@"document"];
    cell.textLabel.numberOfLines = 0;

    NSString *text = [@"" stringByPaddingToLength:(NSUInteger)(rand() / (float)RAND_MAX * 100.0)+50 withString:@"Bacon ipsum dolor amet spare ribs drumstick hamburger prosciutto, fatback leberkas chuck pork chop. Capicola shoulder pork chop swine meatball chuck biltong rump jowl picanha shankle t-bone leberkas tail pork belly. Prosciutto meatloaf biltong, chicken ground round short loin filet mignon pig sausage meatball corned beef alcatra porchetta andouille fatback. Tail filet mignon ball tip flank ground round, tenderloin jerky beef capicola swine rump. Sirloin ground round short ribs spare ribs boudin tail pastrami meatloaf beef bacon ham hock." startingAtIndex:0];
    cell.textLabel.text = text;

    return cell;
}

@end
