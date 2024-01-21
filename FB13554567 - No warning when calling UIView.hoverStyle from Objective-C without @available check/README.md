# FB13554567: No warning when calling UIView.hoverStyle from Objective-C without @available check

## Which area are you seeing an issue with?

Xcode

## What type of feedback are you reporting?

Incorrect/Unexpected Behavior

## What version of Xcode are you using?

15.2 (15C500b)

## Description

(I wasn’t sure whether the file this under UIKit or developer tools.)

UIView.hoverStyle is only available from iOS 17.0. However writing code using this property in Objective-C without an @available check in a project a deployment target before iOS 17.0 will not produce a warning.

### Steps to reproduce

1. Open the attached sample project in WeakLinkTest.zip
2. Note the compiler warnings

### Expected

There should be warnings on lines 40 and 41 in main.m.

### Observed

There are no warnings on these lines. If you run the app on iOS 15 or 16, it will crash with *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[UIView setHoverStyle:]: unrecognized selector sent to instance 0x135e09cb0' *** Note: Warnings for this API seem fine in Swift.
