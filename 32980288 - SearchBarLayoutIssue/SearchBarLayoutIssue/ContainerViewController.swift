//
//  ContainerViewController.swift
//  SearchBarLayoutIssue
//
//  Created by Stefan Kieleithner on 23/06/2017.
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let childController = SearchableViewController()

        addChildViewController(childController)
        view.addSubview(childController.view)
        childController.didMove(toParentViewController: self)
        view.layoutIfNeeded()

        childController.view.frame = view.bounds
        childController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        navigationController?.view.setNeedsLayout()
    }
}
