//
//  ViewController.m
//  KVODeregisterCrash
//
//  Created by Peter Steinberger on 07.09.17.
//  Copyright © 2017 Peter Steinberger. All rights reserved.
//

#import "ViewController.h"

static char PSPDFKVOToken;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionInitial context:&PSPDFKVOToken];
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSString *, id> *)change context:(nullable void *)context {
    if (context != &PSPDFKVOToken) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }

    // Remove it right in the callback! This causes an immediate crash but should work.

    /*
     *** Terminating app due to uncaught exception 'NSRangeException', reason: 'Cannot remove an observer <ViewController 0x7fb5b9503620> for the key path "title" from <ViewController 0x7fb5b9503620> because it is not registered as an observer.'
     *** First throw call stack:
     (
     0   CoreFoundation                      0x00000001011961cb __exceptionPreprocess + 171
     1   libobjc.A.dylib                     0x0000000100af8f41 objc_exception_throw + 48
     2   CoreFoundation                      0x000000010120ab95 +[NSException raise:format:] + 197
     3   Foundation                          0x0000000100525622 -[NSObject(NSKeyValueObserverRegistration) _removeObserver:forProperty:] + 497
     4   Foundation                          0x00000001005253d8 -[NSObject(NSKeyValueObserverRegistration) removeObserver:forKeyPath:] + 84
     5   KVODeregisterCrash                  0x00000001001ed7ac -[ViewController observeValueForKeyPath:ofObject:change:context:] + 220
     6   Foundation                          0x000000010050ee5a NSKeyValueNotifyObserver + 349
     7   Foundation                          0x00000001004ef43e -[NSObject(NSKeyValueObserverRegistration) _addObserver:forProperty:options:context:] + 255
     8   Foundation                          0x00000001004ee30c -[NSObject(NSKeyValueObserverRegistration) addObserver:forKeyPath:options:context:] + 103
     9   KVODeregisterCrash                  0x00000001001ed6c1 -[ViewController viewDidLoad] + 113
     10  UIKit                               0x00000001032fcfe7 -[UIViewController loadViewIfRequired] + 1235
     11  UIKit                               0x00000001032fd434 -[UIViewController view] + 27
     12  UIKit                               0x00000001031d3a8b -[UIWindow addRootViewControllerViewIfPossible] + 122
     13  UIKit                               0x00000001031d417d -[UIWindow _setHidden:forced:] + 294
     14  UIKit                               0x00000001031e701f -[UIWindow makeKeyAndVisible] + 42
     */
    [self removeObserver:self forKeyPath:@"title"];
}

@end
