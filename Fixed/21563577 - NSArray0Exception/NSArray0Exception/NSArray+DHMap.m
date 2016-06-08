// Douglas Hill, June 2015

#import "NSArray+DHMap.h"

@implementation NSArray (DHMap)

- (instancetype)dh_arrayByMappingObjectsUsingMap:(DHObjectMap)map
{
	NSMutableArray *mappedArray = [NSMutableArray arrayWithCapacity:[self count]];
	
	for (id object in self) {
		[mappedArray addObject:map(object)];
	}

    return [[[self class] alloc] initWithArray:mappedArray];
}

@end
