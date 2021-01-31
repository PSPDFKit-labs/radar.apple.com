//
//  ViewController.swift
//  SwiftUIKeyboard
//
//  Created by Peter Steinberger on 30.01.21.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)

        let host = UIHostingController(rootView: SwiftUIView())
        // Uncomment to apply fix
        //host.applyKeyboardShortcutFix()
        present(host, animated: true, completion: nil)

    }

}

extension UIHostingController {

    /// Applies workaround so `keyboardShortcut` can be used via SwiftUI.
    ///
    /// When `UIHostingController` is used as a non-root controller with UIKit app lifecycle,
    /// keyboard shortcuts created in SwiftUI are not working (as of iOS 14.4).
    /// This workaround is harmless and triggers an internal state change that enables keyboard shortcut bridging.
    func applyKeyboardShortcutFix() {
        #if !targetEnvironment(macCatalyst)
        let window = UIWindow()
        window.rootViewController = self
        window.isHidden = false;
        #endif
    }
}
