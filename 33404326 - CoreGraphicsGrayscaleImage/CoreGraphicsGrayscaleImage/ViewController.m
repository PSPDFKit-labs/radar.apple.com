//
//  ViewController.m
//  CoreGraphicsGrayscaleImage
//
//  Created by Michael Ochs on 7/4/17.
//  Copyright © 2017 bitecode. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *copiedImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"##### PROCESSING ORIGINAL IMAGE:");
    UIImage *image = [UIImage imageNamed:@"pin"];
    [self archiveUnarchiveAndDraw:image];
    self.imageView.image = image;
    NSLog(@"##### DONE\n");

    NSLog(@"##### PROCESSING REDRAWN IMAGE:");
    UIImage *imageCopy = [self redrawImage:image];
    [self archiveUnarchiveAndDraw:imageCopy];
    self.copiedImageView.image = imageCopy;
    NSLog(@"##### DONE\n");
}

- (void)archiveUnarchiveAndDraw:(UIImage *)image {
    NSLog(@"Image alpha info: %d", CGImageGetAlphaInfo(image.CGImage));
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:image];
    UIImage *unarchivedImage = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"Unarchived image alpha info: %d", CGImageGetAlphaInfo(unarchivedImage.CGImage));
    [self redrawImage:unarchivedImage];
}

- (UIImage *)redrawImage:(UIImage *)image {
    CGImageRef imageRef = image.CGImage;
    CGContextRef ctx = CGBitmapContextCreate(NULL, CGImageGetWidth(imageRef), CGImageGetHeight(imageRef), CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), CGImageGetColorSpace(imageRef), CGImageGetBitmapInfo(imageRef));
    CGContextDrawImage(ctx, (CGRect){.size = {.width = CGImageGetWidth(imageRef), .height = CGImageGetHeight(imageRef)}}, imageRef);
    CGImageRef redrawnImageRef = CGBitmapContextCreateImage(ctx);
    UIImage *redrawnImage = [UIImage imageWithCGImage:redrawnImageRef scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(redrawnImageRef);
    CGContextRelease(ctx);

    return redrawnImage;
}

@end
