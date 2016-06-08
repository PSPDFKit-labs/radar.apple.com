//
//  SwiftTest.swift
//  SwiftLambdaBlock
//
//  Created by Peter Steinberger on 27/10/15.
//  Copyright © 2015 PSPDFKit GmbH. All rights reserved.
//

import Foundation
import TestLib

@objc class SwiftTest : NSObject {
    override init() {
        super.init()

        TestClass.callLambda { () -> String in
            return "123"
        }
    }
}
