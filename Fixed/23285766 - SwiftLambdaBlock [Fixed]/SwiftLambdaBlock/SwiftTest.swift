//
//  SwiftTest.swift
//  SwiftLambdaBlock
//
//  Created by Peter Steinberger on 27/10/15.
//  Copyright © 2015 PSPDFKit GmbH. All rights reserved.
//

import Foundation

@objc class SwiftTest : NSObject {
    override init() {
        super.init()

        let test = "123456"

        TestClass(URL: NSURL(string: "http://google.com"), passphraseProvider: { () -> String! in
            return test
            }, salt: "123", rounds: 1)!
    }

}
