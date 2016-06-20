//
//  ViewController.m
//  NSBundleFolderLoadingIssue
//
//  Created by Peter Steinberger on 20/06/16.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

#define PSPDFTestAssetFolderName @"assets"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *fileName = @"PleaseLoadMeMaybe";
    // This issue only appeared with unicode characters - simple file names work.
    NSString *folderName = [PSPDFTestAssetFolderName stringByAppendingPathComponent:[NSString stringWithFormat:@"Testcase_Search_§.pdf/"]];

    NSString *textFilePathNotWorkingRadar = [[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:@"txt" inDirectory:folderName];

    NSString *textFilePath = [[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:@"txt" inDirectory:[folderName stringByAppendingString:@"/"]];

    BOOL pathsAreEqual = [textFilePathNotWorkingRadar isEqual:textFilePath];
    NSLog(@"Paths are equal? %tu", pathsAreEqual);

    NSError *error;
    NSString *extractedText = [NSString stringWithContentsOfFile:textFilePathNotWorkingRadar encoding:NSUTF8StringEncoding error:&error];

    NSLog(@"Got: %@", extractedText);

//    XCTAssertNil(error, @"Failed to load extracted text from file: %@", textFilePath);
}

@end
