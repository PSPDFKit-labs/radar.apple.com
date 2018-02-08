//
//  ViewController.m
//  CSTest
//
//  Created by Aditya Krishnadevan on 08/02/2018.
//  Copyright © 2018 caughtinflux. All rights reserved.
//

#import "ViewController.h"
@import CoreSpotlight;
@import CoreServices;

@implementation ViewController {
    CSSearchableIndex *_index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _index = [[CSSearchableIndex alloc] initWithName:@"SomeTestIndex"];
    CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(__bridge NSString *)kUTTypePDF];
    attributeSet.title = self.title;
    attributeSet.creator = @"42";
    attributeSet.producer = @"Mark Narwhalberg";
    attributeSet.authorNames = @[@"Darwin", @"Tesla", @"Jobs"];
    attributeSet.subject = @"Nothing!";
    attributeSet.keywords = @[@"Life", @"Universe", @"Everything"];
    attributeSet.contentCreationDate = NSDate.date;
    attributeSet.pageCount = @(100);
    attributeSet.identifier = @"axczxmncbasjdhg";
    attributeSet.fileSize = @(12345);
    attributeSet.contentModificationDate = [NSDate dateWithTimeIntervalSinceNow:5];

    CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:@"deleteME" domainIdentifier:@"cstests" attributeSet:attributeSet];
    [_index deleteAllSearchableItemsWithCompletionHandler:^(NSError *error) {
        [_index indexSearchableItems:@[item] completionHandler:^(NSError *indexingError) {
            if (error != nil) {
                NSLog(@"An error occurred when indexing. %@", error);
            } else {
                NSLog(@"Index completed successfully");
            }
        }];
    }];
}

@end
