//
//  ViewController.m
//  AutoLayoutViewDebuggingIssue
//
//  Created by Peter Steinberger on 23/03/16.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITextView *trapView = [[UITextView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:trapView];

//     The visual debugger calls _firstBaselineOffsetFromTop, however that one throws an assertion if auto layout is not enabled.
//     This can be worked around by adding auto layout constraints to satisfy the if-check inside UITextView, but it's a rather ugly workaround.
//     The view debugger should be fixed to not call this, or UITextView should not assert. Not sure how other components in UIKit assert when calling this.
//
//     2016-03-23 09:50:13.688 PSPDFCatalog[81077:1745805] _firstBaselineOffsetFromTop called from (
//     0   PSPDFKit                            0x0000000100d7378e -[UITextView _firstBaselineOffsetFromTop] + 46
//     1   libViewDebuggerSupport.dylib        0x0000000100aadf77 +[DBGViewDebuggerSupport_iOS firstBaselineOffsetFromTopForView:] + 134
//     2   libViewDebuggerSupport.dylib        0x0000000100aada2d +[DBGViewDebuggerSupport_iOS addLayoutInfoForView:toDict:] + 333
//     3   libViewDebuggerSupport.dylib        0x0000000100aaed8f +[DBGViewDebuggerSupport collectViewInfo:] + 225
//     4   libViewDebuggerSupport.dylib        0x0000000100aaf42f +[DBGViewDebuggerSupport _collectSubviewInfoForView:encodeLayers:] + 46
//     5   libViewDebuggerSupport.dylib        0x0000000100aaf565 +[DBGViewDebuggerSupport _collectSubviewInfoForView:encodeLayers:] + 356
//     6   libViewDebuggerSupport.dylib        0x0000000100aaf565 +[DBGViewDebuggerSupport _collectSubviewInfoForView:encodeLayers:] + 356
//     7   libViewDebuggerSupport.dylib        0x0000000100aaf565 +[DBGViewDebuggerSupport _collectSubviewInfoForView:encodeLayers:] + 356
//     8   libViewDebuggerSupport.dylib        0x0000000100aaf565 +[DBGViewDebuggerSupport _collectSubviewInfoForView:encodeLayers:] + 356
//     9   libViewDebuggerSupport.dylib        0x0000000100aaf565 +[DBGViewDebuggerSupport _collectSubviewInfoForView:encodeLayers:] + 356
//     10  libViewDebuggerSupport.dylib        0x0000000100aae8cb +[DBGViewDebuggerSupport fetchViewHierarchy] + 336
//     11  ???                                 0x000000011a384a6b 0x0 + 4734863979
//     12  PSPDFCatalog                        0x00000001007664e0 main + 0
//     13  CoreFoundation                      0x0000000106358434 __CFRunLoopServiceMachPort + 212
//     14  CoreFoundation                      0x000000010635788f __CFRunLoopRun + 1295
//     15  CoreFoundation                      0x00000001063570f8 CFRunLoopRunSpecific + 488
//     16  GraphicsServices                    0x000000010b82dad2 GSEventRunModal + 161
//     17  UIKit                               0x0000000103938f09 UIApplicationMain + 171
//     18  PSPDFCatalog                        0x000000010076654f main + 111
//     19  libdyld.dylib                       0x0000000107e2592d start + 1
//

    // Uncomment this to fix the assertion.
//    trapView.translatesAutoresizingMaskIntoConstraints = NO;
//    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[trapView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(trapView)]];
}


@end
