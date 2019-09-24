//
//  AppDelegate.swift
//  DocumentBrowserBookmarks
//
//  Created by Peter Steinberger on 23.09.19.
//  Copyright © 2019 PSPDFKit GmbH. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    // Forward and call this from the AppDelegate.
     override func buildMenu(with builder: UIMenuBuilder) {
         guard builder.system == .main else { return }

         buildFileMenu(builder)
     }

    static let recentDocumentsKey = "RecentDocuments"
    @objc public func clearRecentMenu() {
        UserDefaults.standard.removeObject(forKey: AppDelegate.recentDocumentsKey)
        UIMenuSystem.main.setNeedsRebuild()
    }

    public func registerRecentFile(_ documentURL: URL) {
        var documentURLs = getRecentFiles()
        // Remove element and re-add at the end.
        //documentURLs.remove(documentURL)
        documentURLs.append(documentURL)

        let bookmarksData = documentURLs.compactMap { documentURL in
            (documentURL as NSURL).pspdf_bookmarkData
        }
        UserDefaults.standard.set(bookmarksData, forKey: AppDelegate.recentDocumentsKey)

        UIMenuSystem.main.setNeedsRebuild()
    }

    @objc public func getRecentFiles() -> [URL] {
        let recents = UserDefaults.standard.array(forKey: AppDelegate.recentDocumentsKey) as? [Data] ?? []
        let documentURLs = recents.compactMap { data -> URL? in
            guard let path = NSURL.pspdf_url(withBookmarkData: data)?.path else { return nil }
            return URL(fileURLWithPath: path)
        }
        return documentURLs
    }

     private func buildOpenRecentMenu(_ builder: UIMenuBuilder) -> UIMenuElement {
        var recents: [UIMenuElement] = []
        let documentURLs = getRecentFiles()

        if let documentURL = documentURLs.last {
            let command = UICommand(title: documentURL.lastPathComponent, action:#selector(ViewController.loadLastRecentFile))
            command.image = UIImage(systemName: "paperplane.fill")
            recents.append(command)
        }

         let openRecentMenu = UIMenu(title: "Open Recent", identifier: UIMenu.Identifier("open_recent"), options: [], children: recents)
         return openRecentMenu
     }

     private func buildFileMenu(_ builder: UIMenuBuilder) {
         let fileOperationsMenu = UIMenu(title: "FileOperations", identifier: UIMenu.Identifier("file_operations"), options: [.displayInline], children: [
             buildOpenRecentMenu(builder),
         ])
         builder.insertSibling(fileOperationsMenu, beforeMenu: .close)
     }
}

