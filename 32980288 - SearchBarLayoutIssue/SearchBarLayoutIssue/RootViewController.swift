//
//  RootViewController.swift
//  SearchBarLayoutIssue
//
//  Created by Stefan Kieleithner on 26/06/2017.
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let navController = UINavigationController(rootViewController: ContainerViewController())
        present(navController, animated: true, completion: nil)
    }
}

