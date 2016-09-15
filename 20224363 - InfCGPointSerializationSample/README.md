## NSKeyedArchiver does not correctly preserve CGPoints with INFINITY values

http://openradar.appspot.com/20224363

Summary:
Using encodeCGPoint: forKey: and decodeCGPointForKey: to first encode and later decode a CGPoint with the value of CGPointMake(INFINITY, INFINITY) produces a point with the x and y value set to 0, instead of to INFINITY.

Steps to Reproduce:
Open the attached sample project and run the tests target. 

Expected Results:
The decoded CGPoint would have it’s x and y components set to INFINITY, matching the original.

Actual Results:
The decoded CGPoint has it’s x and y components set to 0, IN CONTRAST WITH the original.

Regression:
Tested on iOS 8 and iOS 7 simulator as well as on an iPhone 6 with iOS 8.2.

Notes:
Encoding a CGFloat with encodeDouble:forKey: and decoding with decodeDoubleForKey: works as expected for INFINITY values.
