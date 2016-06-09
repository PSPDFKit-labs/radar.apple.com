//
//  SwiftTest.swift
//  SwiftLambdaBlock
//
//  Created by Peter Steinberger on 27/10/15.
//  Copyright © 2015 PSPDFKit GmbH. All rights reserved.
//

import Foundation

func doIt(@noescape code: () -> ()) {
    // Uncomment to produce a compiler error
    //dispatch_async(dispatch_get_main_queue(), code);
    code()
}

@objc class SwiftTest : NSObject {
    override init() {
        super.init()

        let test = "123456"

        // @noescape in Swift works as expected
        doIt {
            print(test)
        }

        //  __attribute__((noescape)) not so much...
        let _ = TestClass(URL: NSURL(string: "http://google.com")!, passphraseProvider: { () -> String in
            return test
            }, salt: "123", rounds: 1)
    }
}
