http://openradar.appspot.com/45548500

FileManager.default.url(for:in:appropriateFor:create:) has unexpected behavior in Simulator and creates temporary folders outside the tmp/ directory.
Originator:    steipete    Modify My Radar
Number:    rdar://45548500    Date Originated:    25-Oct-2018 11:19 AM
Status:    Open    Resolved:    
Product:    iOS + SDK    Product Version:    iOS 12GM and 12.1b5
Classification:    Other Bug    Reproducible:    Always

Summary:
based on https://nshipster.com/temporary-files/ we should use following API, not NSTemporaryDirectory():

do {
let temporaryDirectoryURL = try FileManager.default.url(for: .itemReplacementDirectory,
in: .userDomainMask,
appropriateFor: URL(fileURLWithPath: "/"),
create: true)
}

However, this API has various gotchas. Using / as approriateForURL results in an error: Error Domain=NSCocoaErrorDomain Code=513 "You don’t have permission to save the file “System@snap-652843” in the folder “System@snap-652843”." UserInfo={NSURL=file:///, NSUnderlyingError=0x280af3a50 {Error Domain=NSPOSIXErrorDomain Code=1 "Operation not permitted"}}.

Also, behaviour between Device and Simulator is inconsistent.

Steps to Reproduce:
Run example on Simulator and Device. Compare results.

Expected Results:
The API should return correct temp folder even for the root / folder, instead of throwing. Alternatively, the documentation for it should be changed to explain correct use. 

The API should not special-case the Simulator to create temporary folders outside of the /tmp folder - this is highly unexpected and might lead to bugs.

Actual Results:
Simulator behaves different to device. 
API creates an error when passing / as appropriateURL.
Documentation doesn’t explain enough what URL should be passed. https://developer.apple.com/documentation/foundation/filemanager/1407693-url

Version:
iOS 12GM and 12.1b5

Notes:
The modern API is attractive because it returns an URL, and because it ensures the directory is created.

I see that Swift shims the old NSTemporaryDirectory() to FileManager.default.temporaryDirectory. However, there is no additional logic to create the tmp directory, so you can run into edge cases where this directory might be missing. Using the modern API seems to be more appropriate, but is probably difficult due to the above bugs.

https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/FileManager.swift#L1420-L1422

Sample code is the same as following gist: https://gist.github.com/steipete/d7a1506cdb1300cba0a3ae1b11450ab5
