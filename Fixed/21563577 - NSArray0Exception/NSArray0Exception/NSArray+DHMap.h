// Douglas Hill, June 2015

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

typedef id __nonnull (^DHObjectMap)(id object);

@interface NSArray (DHMap)

/**
 Returns an array containing the results of calling map with each of the receiving array’s objects.
 @param map The block that maps from an object in the receiving array to an object to be included in the returned array.
 @return An array containing the results of calling map with each of the receiving array’s objects.
 */
- (instancetype)dh_arrayByMappingObjectsUsingMap:(DHObjectMap)map;

@end

NS_ASSUME_NONNULL_END
