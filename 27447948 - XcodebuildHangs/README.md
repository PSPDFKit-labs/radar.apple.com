## xcodebuild test hangs when piping it's output

http://openradar.appspot.com/27447948

Summary:
The command `xcodebuild test | tee xcodebuild.log` (or piping to any other command) hangs forever.
This is especially bad since CI systems like Jenkins need JUnit output in XML format. This is done by piping xcodebuild’s output into commands like xcpretty. So in other words: `xcodebuild test` is currently completely unusable for CI.

Steps to Reproduce:
Open the attached XcodebuildHangs.zip and call `./test.sh`.
XcodebuildHangs.zip contains a new Xcode project with 1 unit and 1 UI test.
test.sh calls `xcodebuild test | tee xcodebuild.log`.

Expected Results:
xcodebuild runs all tests, outputs all results and exits. xcodebuild.log contains the output.

Actual Results:
xcodebuild runs all tests, outputs all results, but never exits.

Version:
Xcode beta 3 (8S174q)

Notes:
`xcodebuild test` hangs since Xcode 8 beta 1. Everything works correctly in Xcode 7.3.1.

Configuration:
OS X 10.11.6
Xcode beta 3 (8S174q)

Tested on iOS 10 GM, not fixed.
