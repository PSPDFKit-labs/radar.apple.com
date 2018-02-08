# CoreSpotlight indexing fails with mysterious errors if AppSandbox isn't explicitly disabled in Xcode


## Summary:
In a project in which the AppSandbox setting is never touched (under the Capabilities) for the target, all `CSSearchableIndex` operations fail with the error:
```
Error Domain=CSIndexErrorDomain Code=-1003 "(null)" UserInfo={NSUnderlyingError=0x60400044a020 {Error Domain=NSCocoaErrorDomain Code=4097 "Couldn’t communicate with a helper application."}}
```

Filtering by "spotlight" in macOS’s Console.app, the following messages also appear:
```
corespotlightd  com.apple.corespotlight Could not resolve bundle from <xpc object>
corespotlightd  com.apple.corespotlight Could not resolve bundle id for <xpc object>
CSTest  com.apple.corespotlight Retrying <CSSearchableIndexRequest:0x60c00008bf90; id=0, label="delete-all-items", index="SomeTestIndex"/0x60c0000a46e0, retry=1/1> from Error Domain=NSCocoaErrorDomain Code=4097 "Couldn’t communicate with a helper application."
corespotlightd  com.apple.corespotlight Could not resolve bundle from <xpc object>
corespotlightd  com.apple.corespotlight Could not resolve bundle id for <xpc object>
corespotlightd  com.apple.corespotlight Could not resolve bundle from <xpc object>
corespotlightd  com.apple.corespotlight Could not resolve bundle id for <xpc object>
CSTest  com.apple.corespotlight Retrying <CSSearchableIndexRequest:0x60400008a000; id=1, label="index-items", index="SomeTestIndex"/0x60c0000a46e0, retry=1/1> from Error Domain=NSCocoaErrorDomain Code=4097 "Couldn’t communicate with a helper application."
corespotlightd  com.apple.corespotlight Could not resolve bundle from <xpc object>
corespotlightd  com.apple.corespotlight Could not resolve bundle id for <xpc object>
```


## Steps to Reproduce:
1. Run the attached sample application

## Expected Results:
The indexing of the searchable item completes successfully and "Index completed successfully" is logged to the console.

## Actual Results:
The aforementioned error occurs, and "An error occurred when indexing" is logged.

## Version:
10.13.3

## Notes:
A workaround for this issue is to toggle the "App Sandbox" capability for the app target. This adds the following section to the pbxproj, which somehow sets a flag in the binary that allows communication with corespotlightd:
```
SystemCapabilities = {
            com.apple.ApplicationGroups.Mac = {
            enabled = 0;
        };
        com.apple.Sandbox = {
             enabled = 0;
        };
    };
};
```