## ASAN_OPTIONS no longer settable when running tests within Xcode. (Regression)

http://openradar.appspot.com/28103342

Summary:
I'm trying to set ASAN_OPTIONS as environment variable in Xcode based on 
https://github.com/google/sanitizers/wiki/AddressSanitizer

Specifically, I am trying to run without the new odr detection because this seems to be buggy:
http://prod.lists.apple.com/archives/xcode-users/2016/Aug/msg00018.html

>HINT: if you don't care about these errors you may set ASAN_OPTIONS=detect_odr_violation=0

This is not passed to tests. But it works if the app is Run regularly. This is a regression from 7.3.1. Sample is attached that works on both Xcode versions.

Steps to Reproduce:
See attached sample project. Xcode correctly merges it's own ASAN settings with the settings in the environment variable when the app runs normally, but does not do that when I run tests.

I'm using following debug code to make displaying the env variables convenient:

+ (void)load {
NSLog(@"%@", NSProcessInfo.processInfo.environment);
}

Expected Results:
This ist the output when the app runs:
https://gist.github.com/steipete/a7bec36088f3db8d340aa647fc990c13

AddressSanitizer debugger support is active. Memory error breakpoint has been installed and you can now use the 'memory history' command.
2016-08-29 22:53:41.898 AsanOptionTest[98221:1438355] {
"ASAN_OPTIONS" = "abort_on_error=1:color=never:detect_odr_violation=0:asan_option_radar_test_setting=1";
"ASAN_TEST" = "asan-forwarding-works=1";

Actual Results:
This is the output when tests run:
https://gist.github.com/steipete/f9b6c423254f94a3bdbedf865fdadc32

2016-08-29 22:46:37.727 AsanOptionTest[97751:1426969] {
"ASAN_OPTIONS" = "abort_on_error=1:color=never";
"ASAN_TEST" = "asan-forwarding-works=1";

Version:
Xcode 7.3.1 and Xcode 8b6

Notes:
A regular run correctly merges the default settings with custom settings - this does not happen for tests. This is a regression - it works as expected in Xcode 7.3.1.

I opened a DTS for this before because I wasn't sure it was a bug, but it was closed because Xcode is still beta software a few more days. (Number was 646910755)

Configuration:
Xcode 7.3.1 and Xcode 8b6
