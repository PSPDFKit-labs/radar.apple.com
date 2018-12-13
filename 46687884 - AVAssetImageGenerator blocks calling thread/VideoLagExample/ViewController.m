//
//  ViewController.m
//  VideoLagExample
//
//  Created by Aditya Krishnadevan on 13/12/2018.
//  Copyright © 2018 PSPDFKit. All rights reserved.
//

#import "ViewController.h"

@import AVFoundation;

@interface ViewController () {
    AVAssetImageGenerator *_previewGenerator;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *contentURL = [NSURL URLWithString:@"https://s3-eu-west-1.amazonaws.com/yumpu/media/000/000/000/010/000/PEOPLE_ARE_AWESOME_2015_INSANE_EDITION.mp4"];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:contentURL options:nil];
    _previewGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        NSValue *time = [NSValue valueWithCMTime:CMTimeMakeWithSeconds(2.0, 600)];

        CFTimeInterval start = CFAbsoluteTimeGetCurrent();
        // This method blocks the calling thread, even though it sayus that the image generation is async.
        [self->_previewGenerator generateCGImagesAsynchronouslyForTimes:@[time] completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
            NSLog(@"Got image: %@. Error: %@", image, error);
        }];
        NSLog(@"Time for generate method to return: %.3fs", CFAbsoluteTimeGetCurrent() - start);
    });

}


@end
