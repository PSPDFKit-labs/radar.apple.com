//
//  AppDelegate.swift
//  DocumentBrowserDemo
//
//  Created by Matthias Tretter on 16.06.17.
//  Copyright © 2017 @myell0w. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = DocumentBrowserViewController(forOpeningFilesWithContentTypes: ["public.plain-text"])
        self.window?.makeKeyAndVisible()
        return true
    }

    func application(_ app: UIApplication, open inputURL: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        // Reveal / import the document at the URL
        guard let documentBrowserViewController = window?.rootViewController as? DocumentBrowserViewController else { return false }

        documentBrowserViewController.revealDocument(at: inputURL, importIfNeeded: true) { (revealedDocumentURL, error) in
            if let error = error {
                // Handle the error appropriately
                print("Failed to reveal the document at URL \(inputURL) with error: '\(error)'")
                return
            }
            
            // Present the Document View Controller for the revealed URL
            documentBrowserViewController.presentDocument(at: revealedDocumentURL!)
        }

        return true
    }


}

