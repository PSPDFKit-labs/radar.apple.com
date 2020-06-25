# Basic Information

## Please provide a descriptive title for your feedback:

XCFrameworks should bundle and handle debug symbols that will be added to the app's archive

## Which area are you seeing an issue with?

Xcode

## What type of feedback are you reporting?

Suggestion

## Is this Feedback related to a Lab, Engineering Session, or Forum Topic from WWDC20?

Yes, a Lab

## Please provide the lab title:

Swift, Compiler, Debugging, and Package Manager lab

# Details:

## What version of Xcode are you using?

Xcode 11 or later (including Xcode 12 beta)

# Description

## Please describe the issue:

At PSPDFKit, we distribute our PDF library as XCFrameworks, and in addition to the binary, we also offer the debug symbols (dSYMs and BCSymbolMaps).

However, when integrating our XCFrameworks, our customers need to perform additional steps (run phase scripts) to include the debug symbols into their app archive. See step 2 of the Manual Integration instructions for PSPDFKit for iOS: https://pspdfkit.com/guides/ios/current/getting-started/integrating-pspdfkit/

XCFrameworks should be able to bundle and include the debug symbols in apps that use them.

Consumers of XCFrameworks should have the option to include or exclude the debug symbols should they want to.

When one creates an archive of a framework (`xcodebuild archive -workspace 'MyFramework.xcworkspace' -scheme 'MyFramework.framework' -configuration Release -destination 'generic/platform=iOS' -archivePath '/path/to/archives/MyFramework.framework-iphoneos.xcarchive' SKIP_INSTALL=NO`), the debug symbols are correctly generated for the archive.

However, when one creates the XCFramework from the archives (`xcodebuild -create-xcframework -framework …`), the debug symbols are not included inside the resulting XCFramework.

This forces the vendor of the XCFramework to document additional integration steps for the consumer to add the debug symbols into their app.

Having debug symbols bundled/managed by the XCFramework itself would facilitate the integration of closed sourced libraries like PSPDFKit. It would also help us a lot in offering PSPDFKit as Swift Package  (https://github.com/PSPDFKit/PSPDFKitSwiftPackage).

Additional Information:

This topic has also been discussed in https://forums.swift.org/t/dsym-support-for-se-0272-package-manager-binary-dependencies/37713 and https://pspdfkit.com/blog/2020/supporting-xcframeworks/#bcsymbolmaps-and-dsyms
