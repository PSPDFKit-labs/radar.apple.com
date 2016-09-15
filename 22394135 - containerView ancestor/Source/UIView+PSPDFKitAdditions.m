#import "UIView+PSPDFKitAdditions.h"

@implementation UIView (PSPDFKitAdditions)

- (NSSet<__kindof UIView *> *)pspdf_recursiveSubviews {
    NSMutableSet *subviews = [NSMutableSet set];
    [self pspdf_addRecursiveSubviewsToSet:subviews];

    return subviews;
}

- (void)pspdf_addRecursiveSubviewsToSet:(NSMutableSet<__kindof UIView *> *)set {
    for (__unsafe_unretained UIView *subview in self.subviews) {
        [set addObject:subview];
        [subview pspdf_addRecursiveSubviewsToSet:set];
    }
}

@end
