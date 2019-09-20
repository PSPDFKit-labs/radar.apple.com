//
//  CustonNavigationViewController.swift
//  BarAppearanceIssue
//
//  Created by Nishant Desai on 20/09/19.
//  Copyright © 2019 Nishant Desai. All rights reserved.
//

import UIKit

class CustonNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Locally setting the background color of the navigation bar to Red.
        // However, this is overridden by the values (green background color) set using Appearance Proxy API.
        // See SceneDelegate.scene(_:willConnectTo:options:) for values assigned using Appearance Proxy API.
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemRed
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
