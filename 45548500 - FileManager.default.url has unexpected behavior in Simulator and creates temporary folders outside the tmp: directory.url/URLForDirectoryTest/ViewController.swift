//
//  ViewController.swift
//  URLForDirectoryTest
//
//  Created by Peter Steinberger on 25.10.18.
//  Copyright © 2018 Peter Steinberger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // tl;dr:  FileManager.default.url(for:in:appropriateFor:create:) has unexpected behavior in Simulator and creates temporary folders outside the tmp/ directory.

        let tmpDirClassic = NSTemporaryDirectory()
        print("tmpDirClassic: \(tmpDirClassic)")
        // This is the same code, just syntax sugar for NSTemporaryDirectory()
        // https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/FileManager.swift#L1420-L1422
        let tmpDirClassicNewShim = FileManager.default.temporaryDirectory
        print("tmpDirClassicNewShim: \(tmpDirClassicNewShim)")

        // Simulator: /Users/steipete/Library/Developer/CoreSimulator/Devices/31C05637-B9C9-482C-A6CE-D063A7CECF64/data/Containers/Data/Application/A68D11A4-88BA-4FCF-A8B1-D102945D0740/tmp/
        // Device: /private/var/mobile/Containers/Data/Application/9D3C6BA4-EE6B-4573-8DC5-66A759D52BC0/tmp/


        // based on https://nshipster.com/temporary-files/ we should use following API, not NSTemporaryDirectory():
        do {
            let temporaryDirectoryURL = try FileManager.default.url(for: .itemReplacementDirectory,
                                                                in: .userDomainMask,
                                                                appropriateFor: URL(fileURLWithPath: "/"),
                                                                create: true)
            print("temporaryDirectoryURL: \(temporaryDirectoryURL)")
        } catch {
            // This prints:
            // Simulator: Unexpected error: Error Domain=NSCocoaErrorDomain Code=513 "You don’t have permission to save the file “Macintosh HD” in the folder “Macintosh HD”." UserInfo={NSURL=file:///, NSUnderlyingError=0x6000008e0870 {Error Domain=NSPOSIXErrorDomain Code=13 "Permission denied"}}.
            // Device: Unexpected error: Error Domain=NSCocoaErrorDomain Code=513 "You don’t have permission to save the file “System@snap-652843” in the folder “System@snap-652843”." UserInfo={NSURL=file:///, NSUnderlyingError=0x280af3a50 {Error Domain=NSPOSIXErrorDomain Code=1 "Operation not permitted"}}.
            print("Unexpected error: \(error).")
        }

        // Using a more appropriate URL works better:
        do {
            // Simulator: /Users/steipete/Library/Developer/CoreSimulator/Devices/31C05637-B9C9-482C-A6CE-D063A7CECF64/data/Containers/Data/Application/CB992FF7-AAC5-4FEF-8839-33122960BB42/Library/Caches
            // Device: /var/mobile/Containers/Data/Application/9D3C6BA4-EE6B-4573-8DC5-66A759D52BC0/Library/Caches/
            let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
            let temporaryDirectoryURL = try FileManager.default.url(for: .itemReplacementDirectory,
                                                                    in: .userDomainMask,
                                                                    appropriateFor: cacheURL,
                                                                    create: true)

            // Prints different paths depending on Simulator or device!
            // Simulator: /Users/steipete/Library/Developer/CoreSimulator/Devices/31C05637-B9C9-482C-A6CE-D063A7CECF64/data/Containers/Data/Application/A68D11A4-88BA-4FCF-A8B1-D102945D0740/Library/(A Document Being Saved By URLForDirectoryTest 2)
            // *** NOTICE HOW THIS IS OUTSIDE THE EXPECTED TEMP DIR! ***
            //
            // Device: /private/var/mobile/Containers/Data/Application/9D3C6BA4-EE6B-4573-8DC5-66A759D52BC0/tmp/(A Document Being Saved By URLForDirectoryTest)
            print("temporaryDirectoryURL: \(temporaryDirectoryURL.path)")

            // What happens if we change the appropriateFor URL to be just the App root?
            // /Users/steipete/Library/Developer/CoreSimulator/Devices/31C05637-B9C9-482C-A6CE-D063A7CECF64/data/Containers/Data/Application/CB992FF7-AAC5-4FEF-8839-33122960BB42/
            // /var/mobile/Containers/Data/Application/9D3C6BA4-EE6B-4573-8DC5-66A759D52BC0/
            let appRoot = cacheURL.deletingLastPathComponent().deletingLastPathComponent()
            let temporaryDirectoryURL2 = try FileManager.default.url(for: .itemReplacementDirectory,
                                                                    in: .userDomainMask,
                                                                    appropriateFor: appRoot,
                                                                    create: true)
            print("temporaryDirectoryURL2: \(temporaryDirectoryURL2.path)")
            // Simulator: /Users/steipete/Library/Developer/CoreSimulator/Devices/31C05637-B9C9-482C-A6CE-D063A7CECF64/data/Containers/Data/Application/(A Document Being Saved By URLForDirectoryTest 3)
            // *** NOTICE HOW THIS IS OUTSIDE THE EXPECTED TEMP DIR! ***
            // Device: /private/var/mobile/Containers/Data/Application/9D3C6BA4-EE6B-4573-8DC5-66A759D52BC0/tmp/(A Document Being Saved By URLForDirectoryTest 2)
        } catch {
            print("Unexpected error: \(error).")
        }

    }


}

