# Basic Information

## Please provide a descriptive title for your feedback:

The archived app's Frameworks directory does not contain the binary frameworks from Swift Package Manager dependencies

## Which area are you seeing an issue with?

Xcode

## What type of feedback are you reporting?

Incorrect/Unexpected Behavior

## Is this Feedback related to a Lab, Engineering Session, or Forum Topic from WWDC20?

Yes, a Lab

## Please provide the lab title:

Swift, Compiler, Debugging, and Package Manager lab

# Details:

## What version of Xcode are you using?

Xcode 12 beta 1

# Description

## Please describe the issue:

When archiving an app that uses our Swift Package (https://github.com/PSPDFKit/PSPDFKitSwiftPackage) the archive Frameworks directory does not contain the binary frameworks from Swift Package Manager dependencies. 

However, if we remove the Swift Package and if we were to integrate the XCFrameworks manually (https://pspdfkit.com/guides/ios/current/getting-started/integrating-pspdfkit/#integrating-the-xcframework), then the `.framework` files will be present in archive `Frameworks` directory.

## Please list the steps you took to reproduce the issue:

- Open the `SwiftExample.xcodeproj` sample project inside `SwiftPackageManagerExample.zip`
- Archive it to “Any iOS Device (Arm64)”
- Notice that the archive is successful.
- Inspect the newly created `.xcarchive`: go  to `SwiftExample-timestamp-.xcarchive/Products/Applications/SwiftExample.app/Frameworks`

## What did you expect to happen?

The `PSPDFKit.framework` and `PSPDFKitUI.framework` should be present in `SwiftExample-timestamp-.xcarchive/Products/Applications/SwiftExample.app/Frameworks` like when using the manual integration of the XCFrameworks. See the attached screenshots.

## What actually happened?

The `PSPDFKit.framework` and `PSPDFKitUI.framework` are not present in  `SwiftExample-timestamp-.xcarchive/Products/Applications/SwiftExample.app/Frameworks`.
