//
//  MyObject.swift
//  ExtensibleStringEnums
//
//  Created by Michael Ochs on 8/23/16.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

import UIKit

class MyObject: NSObject {

    func doStuff() {
        let myDefines = Defines()
        myDefines.doSomething(nil)

        // If you add this line, everything compiles just fine:
//        myDefines.doSomething([.ignoreDisplaySettingsKey: true])
    }

}
