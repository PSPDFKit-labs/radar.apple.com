## NSBundle's path resolution is broken with unicode

http://openradar.appspot.com/26897226

Area:
Something not on this list

Summary:
Area: Foundation. (Why is that not on the list?)

 [[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:@"txt" inDirectory:folderName]; clips too much when the directory contains unicode characters.

Steps to Reproduce:
Open Radar. Observe that there are no lyrics loaded for Call Me Maybe.
Replace textFilePathNotWorkingRadar with textFilePath to get lyrics :)

Radar sample code is on https://github.com/PSPDFKit-labs/radar.apple.com. I uploaded it here as well, but please use the GitHub one as we often tweak and update sample projects.

Expected Results:
Unicode should just work. I know, it's not that easy ;)

Actual Results:
One character at the end is removed, breaking the path.

Version:
iOS 9.3.2

Notes:
Same issue in Xcode 8b1/iOS 10.0b1

Configuration:
Xcode 7.3.1

Tested on iOS 10 GM, not fixed.
