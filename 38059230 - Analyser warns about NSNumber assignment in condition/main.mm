#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    NSNumber *_Nullable nullableNSNumber = nil;
    if (auto const nonnullNSNumber = nullableNSNumber) {

    }

    return 0;
}
