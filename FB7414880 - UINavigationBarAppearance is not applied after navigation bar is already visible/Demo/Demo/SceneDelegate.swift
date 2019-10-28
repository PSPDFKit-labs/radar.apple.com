//
//  SceneDelegate.swift
//  Demo
//
//  Created by Adrian Kashivskyy on 28/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let viewController = ViewController()
        let navigationController = UINavigationController(rootViewController: viewController)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }

}
