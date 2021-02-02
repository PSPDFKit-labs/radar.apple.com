//
//  MagicRecorder.m
//  MagicKit
//
//  Created by Peter Steinberger on 02.02.21.
//

#import "MagicRecorder.h"

@implementation MagicRecorder

- (instancetype)init {
    self = [super init];
    self.player = [AVAudioPlayer new];
    return self;
}

@end
