//
//  ViewController.m
//  FilePresenterCallbacksExample
//
//  Created by Matej Bukovinski on 22/06/2017.
//  Copyright © 2017 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"
#import "Document.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *firstStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondStatusLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Actions

- (IBAction)runExample:(UIButton *)sender {
    sender.enabled = NO;
    [self.activityIndicator startAnimating];

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *documentPath = [documentsDirectory stringByAppendingPathComponent:@"file.txt"];

        // Using URLWithString: instead of fileURLWithPath: will cause file coordination and NSFilePresenter to
        // fail silently. No file coordination appears to be performed and no NSFilePresenter change notifications
        // are invoked. But the file is still changed on disk.

        // If the two calls below are switched then the example works as intended.
        NSURL *documentURL = [NSURL URLWithString:documentPath];
        // NSURL *documentURL = [NSURL fileURLWithPath:documentPath];

        if (documentURL.isFileURL) {
            NSLog(@"Using a file URL.");
        } else {
            NSLog(@"NOT using a file URL.");
        }

        NSError *error;
        BOOL succeed = [@"Initial Data" writeToFile:documentPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        NSAssert(succeed, @"Initial write should not fail. Error: %@", error);

        Document *firstDocument = [[Document alloc] initWithPresentedItemURL:documentURL string:@"First Document Data"];
        [NSFileCoordinator addFilePresenter:firstDocument];

        Document *secondDocument = [[Document alloc] initWithPresentedItemURL:documentURL string:@"Second Document Data"];
        [NSFileCoordinator addFilePresenter:secondDocument];

        dispatch_group_t waitGroup = dispatch_group_create();

        dispatch_group_enter(waitGroup);
        [firstDocument writeWithCompletion:^{
            dispatch_group_leave(waitGroup);
        }];

        dispatch_group_enter(waitGroup);
        [secondDocument writeWithCompletion:^{
            dispatch_group_leave(waitGroup);
        }];

        dispatch_group_wait(waitGroup, DISPATCH_TIME_FOREVER);

        // Poor man's busy wait. Don't judge. :)
        const NSTimeInterval interval = 1;
        const NSTimeInterval timeout = 5;
        NSTimeInterval passed = 0;
        while (!(firstDocument.presentedItemDidChangeCalled && secondDocument.presentedItemDidChangeCalled)) {
            sleep(interval);
            passed += interval;
            if (passed >= timeout) { break; }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateLabel:self.firstStatusLabel forSucess:firstDocument.presentedItemDidChangeCalled];
            [self updateLabel:self.secondStatusLabel forSucess:secondDocument.presentedItemDidChangeCalled];

            sender.enabled = YES;
            [self.activityIndicator stopAnimating];
        });
    });
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (void)updateLabel:(UILabel *)label forSucess:(BOOL)sucess {
    if (sucess) {
        label.textColor = UIColor.greenColor;
        label.text = @"YES";
    } else {
        label.textColor = UIColor.redColor;
        label.text = @"NO";
    }
}

@end
