//
//  ViewController.swift
//  SpringboardDestroyer
//
//  Created by Peter Steinberger on 31/05/2017.
//  Copyright © 2017 Peter Steinberger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let badwork = { (queue: DispatchQueue) in
            queue.async {
                let app = UIApplication.shared

                for index in 0..<100000 {

                    let name = "Yolo \(index)"
                    let identifier = app.beginBackgroundTask(withName: name, expirationHandler: {
                        print("Expired")
                    });
                    print("Started \(identifier)")

                    let time = DispatchTime.now() + Double(arc4random_uniform(1000))/10.0
                    queue.asyncAfter(deadline: time, execute: {
                        app.endBackgroundTask(identifier)
                        print("Ended \(identifier)")
                    })
                }
            }
        }

        let userQueue = DispatchQueue.global(qos: .userInitiated)
        badwork(userQueue)

        let defaultQueue = DispatchQueue.global(qos: .default)
        badwork(defaultQueue)

        let interactiveQueue = DispatchQueue.global(qos: .userInteractive)
        badwork(interactiveQueue)
    }
}

