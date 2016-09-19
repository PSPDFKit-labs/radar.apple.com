//
//  PopoverViewController.swift
//  ActionSheetInPopoverRotationIssue
//
//  Created by Matej Bukovinski on 29. 06. 16.
//  Copyright © 2016 Matej Bukovinski. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tap Me", style: .plain, target: self, action: #selector(showActionSheet(sender:)))
    }

    func showActionSheet(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Now rotate the device", style: .destructive, handler: nil))

        guard let popoverPresentation = alertController.popoverPresentationController else { return }
        popoverPresentation.barButtonItem = sender

        self.present(alertController, animated: true, completion: nil)
    }

}
