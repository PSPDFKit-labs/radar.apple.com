//
//  ActionViewController.m
//  ImageSharing
//
//  Created by Michael Ochs on 1/8/17.
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

#import "ActionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ActionViewController ()

@property(strong,nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get the item[s] we're handling from the extension context.
    
    // For example, look for an image and place it into an image view.
    // Replace this with something appropriate for the type[s] your extension supports.
    BOOL imageFound = NO;
    for (NSExtensionItem *item in self.extensionContext.inputItems) {
        for (NSItemProvider *itemProvider in item.attachments) {
            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]) {
                // This is an image. We'll load it, then place it in our image view.
                __weak UIImageView *imageView = self.imageView;
                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(id<NSSecureCoding, NSObject> item, NSError *error) {
                    if (![item isKindOfClass:NSURL.class]) {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error getting a URL" message:[NSString stringWithFormat:@"Expected an instance of NSURL but instead got %@", item.class] preferredStyle:UIAlertControllerStyleAlert];
                            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:NULL]];
                            [self presentViewController:alert animated:YES completion:NULL];
                        }];
                        return;
                    }

                    NSURL *fileURL = (NSURL *)item;

                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    NSURL *documentsDirectory = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
                    NSURL *targetURL = [[documentsDirectory URLByAppendingPathComponent:NSUUID.UUID.UUIDString] URLByAppendingPathExtension:fileURL.pathExtension];

                    // stream over the image since we can't copy the file (see rdar://29918507 )
                    NSInputStream *input = [NSInputStream inputStreamWithURL:fileURL];
                    NSOutputStream *output = [NSOutputStream outputStreamWithURL:targetURL append:NO];

                    [input open];
                    [output open];

                    NSInteger bytesRead = 0;
                    uint8_t buffer[512] = { 0 };
                    while ((bytesRead = [input read:buffer maxLength:512])) {
                        if (bytesRead > 0) {
                            [output write:buffer maxLength:bytesRead];
                        } else {
                            break;
                        }
                    }

                    if (input.streamError == nil && output.streamError == nil) {
                        [input close];
                        [output close];

                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            [imageView setImage:[UIImage imageWithContentsOfFile:targetURL.path]];
                        }];
                    } else {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error during -[NSFileManager copyItemAtURL:toURL:error:]" message:(input.streamError ?: output.streamError).localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:NULL]];
                            [self presentViewController:alert animated:YES completion:NULL];
                        }];
                    }
                }];
                
                imageFound = YES;
                break;
            }
        }
        
        if (imageFound) {
            // We only handle one image, so stop looking for more.
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done {
    // Return any edited content to the host app.
    // This template doesn't do anything, so we just echo the passed in items.
    [self.extensionContext completeRequestReturningItems:self.extensionContext.inputItems completionHandler:nil];
}

@end
