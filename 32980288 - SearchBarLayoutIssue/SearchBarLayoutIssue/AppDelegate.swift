//
//  AppDelegate.swift
//  SearchBarLayoutIssue
//
//  Created by Stefan Kieleithner on 23/06/2017.
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let backgroundImage = UIImage(named: "NavigationBarBackground")

        // Comment out to position the search bar correctly.
        UINavigationBar.appearance().setBackgroundImage(backgroundImage, for: .default)
        return true
    }
}
