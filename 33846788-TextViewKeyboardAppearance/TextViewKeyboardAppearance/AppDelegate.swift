//
//  AppDelegate.swift
//  TextViewKeyboardAppearance
//
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let textView = UITextView.appearance()

        // The following line triggers an assertion in `UIAppearance.m`.
        textView.keyboardAppearance = .dark

        return true
    }

}
