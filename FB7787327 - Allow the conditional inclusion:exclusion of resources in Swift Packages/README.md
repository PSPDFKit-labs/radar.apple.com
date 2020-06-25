# Basic Information

## Please provide a descriptive title for your feedback:

Allow the conditional inclusion/exclusion of resources in Swift Packages

## Which area are you seeing an issue with?

Xcode

## What type of feedback are you reporting?

Suggestion

## Is this Feedback related to a Lab, Engineering Session, or Forum Topic from WWDC20?

Yes, an Engineering Session

## Please provide the lab title:

Swift packages: Resources and localization

# Details:

## What version of Xcode are you using?

Xcode 12 beta 1

# Description

## Please describe the issue:

Currently, one can specify resource files in the Package manifest. Those resources are static and they will all be downloaded with Swift Package and processed in the host app.

It would be very useful to allow the end-user to only include a subset of the bundled resources from the Swift Package. Similarly to how other 3rd party dependency managers allow this. For example, CocoaPods handles such uses cases via subspecs (https://guides.cocoapods.org/syntax/podspec.html#subspec)

Here’s a concrete example of how we intend to use this feature at PSPDFKit.

We plan on releasing a new framework (`PSPDFKitOCR.xcframework`) and in addition to the binary we will be offering training language files as `.bundles`. For example, `English.bundle`, `French.bundle`. Each language file will be about 20 MB in size and we plan on offering about 20 languages. This will dramatically increase the download size for our end users who may only want to support a handful of languages.

Please note that the OCR language files are not directly mapped to the currently used system locale therefore we can’t use localized resources. Some of our customer’s apps may support a single locale, but they may want to perform OCR operations on multiple languages.

This feature would offer a mechanism to the end-user of the Swift Package to only specify the desired resources to download in the first place.
