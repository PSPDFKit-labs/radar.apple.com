//
//  ViewController.m
//  UITableViewControllerDesignatedInitializerIssue
//
//  Created by Peter Steinberger on 15/04/15.
//  Copyright (c) 2015 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"

// API Unavailability
// Declares the parameterless `-init` and `+new` as unavailable.
#ifndef PSPDF_NOT_DESIGNATED_INITIALIZER_ATTRIBUTE
#define PSPDF_NOT_DESIGNATED_INITIALIZER_ATTRIBUTE \
__attribute__((unavailable("Not the designated initializer")))
#endif // PSPDF_NOT_DESIGNATED_INITIALIZER_ATTRIBUTE

#define PSPDF_EMPTY_INIT_UNAVAILABLE \
- (instancetype)init PSPDF_NOT_DESIGNATED_INITIALIZER_ATTRIBUTE; \
+ (instancetype)new PSPDF_NOT_DESIGNATED_INITIALIZER_ATTRIBUTE;

#define PSPDF_NOT_DESIGNATED_INITIALIZER() PSPDF_NOT_DESIGNATED_INITIALIZER_CUSTOM(init)
#define PSPDF_NOT_DESIGNATED_INITIALIZER_CUSTOM(initName) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wobjc-designated-initializers\"") \
- (instancetype)initName \
{ do { \
NSAssert2(NO, @"%@ is not the designated initializer for instances of %@.", NSStringFromSelector(_cmd), NSStringFromClass([self class])); \
return nil; \
} while (0); } \
_Pragma("clang diagnostic pop")


@interface SampleTableViewController : UITableViewController
PSPDF_EMPTY_INIT_UNAVAILABLE
- (instancetype)initWithAnnotations:(NSArray *)annotations NS_DESIGNATED_INITIALIZER;
@end

@implementation SampleTableViewController

PSPDF_NOT_DESIGNATED_INITIALIZER_CUSTOM(initWithStyle:(UITableViewStyle)style)
PSPDF_NOT_DESIGNATED_INITIALIZER_CUSTOM(initWithCoder:(NSCoder *)aDecoder)
PSPDF_NOT_DESIGNATED_INITIALIZER_CUSTOM(initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil)

- (instancetype)initWithAnnotations:(NSArray *)annotations {
    if ((self = [super initWithStyle:UITableViewStylePlain])) {
        // do stuff with annotations
    }
    return self;
}

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    SampleTableViewController *controller = [[SampleTableViewController alloc] initWithAnnotations:@[]];
    [self presentViewController:controller animated:YES completion:NULL];
}

@end
