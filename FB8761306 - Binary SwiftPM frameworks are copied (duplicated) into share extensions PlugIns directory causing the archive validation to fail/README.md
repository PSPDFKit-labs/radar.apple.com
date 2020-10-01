# Basic Information

## Please provide a descriptive title for your feedback:

Binary SwiftPM frameworks are copied (duplicated) into share extensions PlugIns directory causing the archive validation to fail

## Which area are you seeing an issue with?

Xcode

## What type of feedback are you reporting?

Incorrect/Unexpected Behavior

# Details:

## What version of Xcode are you using?

Version 12.0 (12A7209) and Version 12.2 beta 2 (12B5025f)

# Description

## Please describe the issue:

Binary SwiftPM frameworks are copied (duplicated) into share extensions PlugIns directory causing the archive validation to fail. This is likely because `PSPDFKit.framework` and `PSPDFKitUI.framework` are copied into the `PlugIns` directory, in addition to them being already into the `Frameworks` directory in the app’s bundle. See the `Finder-Frameworks` and `Finder-PlugIns` screenshot. Please also refer to the `Organizer-Duplicated-Frameworks` and `Validation-Failed`.

Note that this problem only occurs for projects that have an app (share) extension and that use Swift Package Manager with binary frameworks.

The issue does not occur for projects without a share extension (see the attached `Minimal.zip` sample project) or in projects with an app extension that does not use SwiftPM (see the attached `Minimal-ShareExtension-Manual-Integration.zip` sample project) 

## Please list the steps you took to reproduce the issue:

- Unzip `Minimal-ShareExtension.zip` and open `Minimal.xcodeproj`
- Archive the `Minimal` for `Generic iOS Device (arm64)`
- Validate the archive

## What did you expect to happen?

The validation should be successful.

## What actually happened?

The validation fails.
