//
//  ViewController.m
//  ProtectedPDFSample
//
//  Created by Matej Bukovinski on 11. 08. 15.
//  Copyright © 2015 PSPDFKit. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self verifyPDFWithName:@"non-protected"];
    [self verifyPDFWithName:@"protected"];
}

- (void)verifyPDFWithName:(NSString *)name {
    NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:@"pdf"];
    NSAssert(url, @"The pdf has to be available (%@.pdf). URL: %@", name, url);

    CGPDFDocumentRef documentRef = CGPDFDocumentCreateWithURL((CFURLRef)url);
    NSAssert(documentRef, @"The document ref has to be created (%@.pdf).", name);
}

@end
