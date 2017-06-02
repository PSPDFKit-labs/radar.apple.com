//
//  ViewController.swift
//  CompletionBlockClearing
//
//  Created by Peter Steinberger on 02/06/2017.
//  Copyright © 2017 Peter Steinberger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let op = Operation()
        op.completionBlock = {
            print(op.completionBlock as Any)  // prints "Optional((Function))"


            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                print(op.completionBlock as Any) // prints "Optional((Function))"

                op.completionBlock = nil
                print(op.completionBlock as Any) // prints "nil"
            })
        }
        print(op.completionBlock as Any)  // prints "nil"
        
        op.start()
    }

}

