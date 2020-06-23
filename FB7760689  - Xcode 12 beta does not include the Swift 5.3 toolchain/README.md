FB7760689  - Xcode 12 beta does not include the Swift 5.3 toolchain

Please provide a descriptive title for your feedback:
Xcode 12 beta does not include the Swift 5.3 toolchain

Which area are you seeing an issue with?
Xcode

What type of feedback are you reporting?
Incorrect/Unexpected Behavior

Is this Feedback related to a Lab, Engineering Session, or Forum Topic from WWDC20?
Yes, an Engineering Session

Please provide the session title:
https://developer.apple.com/videos/play/wwdc2020/10169/

What version of Xcode are you using?
12.0 beta

Please describe the issue:

In https://developer.apple.com/videos/play/wwdc2020/10169/ at the 9:07 timestamp, it is mentioned that Xcode 12 comes with Swift toolchain 5.3.

I fact, Xcode 12 includes version 5.2.4

Please list the steps you took to reproduce the issue:

1. Make sure Xcode 12 beta is installed on your Mac.
2. run `sudo xcode-select --switch /Applications/Xcode-beta.app/Contents/Developer/` to switch to Xcode 12.
3. Run `swift --version`

What did you expect to happen?

The command output should be: 
Apple Swift version 5.3.x

What actually happened?
Apple Swift version 5.2.4 (swiftlang-1103.0.32.9 clang-1103.0.32.53)
Target: x86_64-apple-darwin19.5.0
