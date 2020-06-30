//
//  AppDelegate.h
//  ObjCDirectSelBug
//
//  Created by Peter Steinberger on 30.06.20.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

// https://pspdfkit.com/blog/2020/improving-performance-via-objc-direct/
// https://nshipster.com/direct/
// Direct method and property calls increases performance and reduces binary size.
// Checking if the attribute is supported doesn't work, Xcode 11 supports it but gives a compile time error.
// Setting DISABLE_OBJC_DIRECT in the build settings will disable this feature.
#if defined(__IPHONE_14_0) || defined(__MAC_10_16) || defined(__TVOS_14_0) || defined(__WATCHOS_7_0)
#define PSPDF_OBJC_DIRECT_MEMBERS __attribute__((objc_direct_members))
#define PSPDF_OBJC_DIRECT __attribute__((objc_direct))
#define PSPDF_DIRECT ,direct
#else
#define PSPDF_OBJC_DIRECT_MEMBERS
#define PSPDF_OBJC_DIRECT
#define PSPDF_DIRECT
#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@end

