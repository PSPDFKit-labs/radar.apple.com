//
//  SceneDelegate.swift
//  Gallery
//
//  Copyright © 2019 Apple, Inc. All rights reserved.
//

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
This class demonstrates how to use the scene delegate to configure a scene's interface.
 It also implements basic state restoration.
*/

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    // UIWindowScene delegate
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let userActivity = connectionOptions.userActivities.first ?? session.stateRestorationActivity {
            if !configure(window: window, with: userActivity) {
                print("Failed to restore from \(userActivity)")
            }
        }

        // If there were no user activities, we don't have to do anything.
        // The `window` property will automatically be loaded with the storyboard's initial view controller.
    }
  
    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        return scene.userActivity
    }
    
    // Utilities
    
    func configure(window: UIWindow?, with activity: NSUserActivity) -> Bool {
        if activity.title == GalleryOpenDetailPath {
            if let photoID = activity.userInfo?[GalleryOpenDetailPhotoIdKey] as? String {
                
                if let photoDetailViewController = PhotoDetailViewController.loadFromStoryboard() {
                    photoDetailViewController.photo = Photo(name: photoID)
                    
                    if let navigationController = window?.rootViewController as? UINavigationController {
                        navigationController.pushViewController(photoDetailViewController, animated: false)
                        return true
                    }
                }
            }
        }
        return false
    }
}
