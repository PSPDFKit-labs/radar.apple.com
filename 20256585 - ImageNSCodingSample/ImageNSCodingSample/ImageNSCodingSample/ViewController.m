//
//  ViewController.m
//  ImageNSCodingSample
//
//  Created by Matej Bukovinski on 20. 03. 15.
//  Copyright (c) 2015 PSPDFKit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Tests

- (IBAction)testImageNamedSerialization {
    UIImage *image = [UIImage imageNamed:@"exampleimage.jpg"];

    NSData *data = nil;
    NSString *string = [self serializeImage:image outData:&data];
    self.textView.text = string;

    BOOL containsData = [string containsString:@"NS.data"];
    NSString *info = [NSString stringWithFormat:@"Testing imageNamed:\n - size %lu bytes\n - contains NS.data section: %@", (unsigned long)[data length], containsData ? @"YES" : @"NO"];
    self.infoLabel.text = info;
}

- (IBAction)testImageWithContentsOfFileSerialization {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"exampleimage" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];

    NSData *data = nil;
    NSString *string = [self serializeImage:image outData:&data];
    self.textView.text = string;

    BOOL containsData = [string containsString:@"NS.data"];
    NSString *info = [NSString stringWithFormat:@"Testing pathForResource:ofType:\n - size %lu bytes\n - contains NS.data section: %@", (unsigned long)[data length], containsData ? @"YES" : @"NO"];
    self.infoLabel.text = info;
}

- (NSString *)serializeImage:(UIImage *)image outData:(NSData **)data {
    NSMutableData *archivedData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archivedData];
    [archiver setOutputFormat:NSPropertyListXMLFormat_v1_0];
    [archiver encodeRootObject:image];
    [archiver finishEncoding];

    if (data) {
        *data = archivedData;
    }

    NSString *dataString = [[NSString alloc] initWithData:archivedData encoding:NSUTF8StringEncoding];
    return dataString;
}

@end
