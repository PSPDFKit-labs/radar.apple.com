//
//  ViewController.swift
//  CompletionBlockClearingMac
//
//  Created by Peter Steinberger on 02/06/2017.
//  Copyright © 2017 Peter Steinberger. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let op = Operation()
        op.completionBlock = {
            print(op.completionBlock as Any)  // prints "nil"


            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                print(op.completionBlock as Any) // prints "nil"

                op.completionBlock = nil
                print(op.completionBlock as Any) // prints "nil"
            })
        }
        print(op.completionBlock as Any)  // prints "Optional((Function))"
        
        op.start()
    }

}

