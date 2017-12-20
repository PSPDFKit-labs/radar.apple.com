# What’s This?

This sample project contains an Objective-C and a Swift sample app to expose an annoyance of `NSURLSessionTask`.
Whenever you push the button in one of the sample app, a log message like the following will be printed to the debug console:

```
<timestamp> Task Force Swift[32801:407445] Task <E9222022-EA65-4105-8AD1-863F9ACB2C64>.<7> finished with error - code: -999
```

As you can clearly see by inspecting the code in `AppDelegate.m` and `AppDelegate.swift`, this log message does not originate in the app. Instead, it appears to come from CFNetworking; and there does not seem to be a way to silence it.

# From the Radar

## Area:
CFNetwork Framework

## Summary:
When cancelling an `NSURLSessionDataTask`, it typically logs this to the debugger console. It really shouldn’t do that, especially if the session’s delegate implements `-[<NSURLSessionDelegate> URLSession:task:didCompleteWithError:]`.

## Steps to Reproduce:
- Build and run any of the schemes in the attached sample project
- make sure you can see the debugger console, and tap on the “Make Request” button

## Expected Results:
If you have a working internet connection, and our website isn’t down, you shouldn’t see _anything_ logged to the console.

## Actual Results:
For every tap on the button, you a line like the following is logged to the console:

```
2017-12-20 17:33:26.708636+0100 Task Force Swift[32801:407445] Task <E9222022-EA65-4105-8AD1-863F9ACB2C64>.<7> finished with error - code: -999
```

## Version/Build:
iOS 11 and above

## Comments

Note: The attached sample project manages to reproduce this with 100% accuracy. If I cancel the task in `URLSession:dataTask:didReceiveResponse:completionHandler:` not every cancellation triggers a log message.