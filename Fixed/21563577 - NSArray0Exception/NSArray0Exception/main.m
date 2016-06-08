// Douglas Hill, June 2015

@import Foundation;

#import "NSArray+DHMap.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSLog(@"%@", [@[@"Works", @"when", @"not", @"empty"] dh_arrayByMappingObjectsUsingMap:^id (id object) {
            return object;
        }]);

        NSLog(@"%@", [@[] dh_arrayByMappingObjectsUsingMap:^id (id object) {
            return object;
        }]);
    }
    return 0;
}
