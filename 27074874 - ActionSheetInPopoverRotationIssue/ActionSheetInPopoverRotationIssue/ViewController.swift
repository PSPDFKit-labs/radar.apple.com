//
//  ViewController.swift
//  ActionSheetInPopoverRotationIssue
//
//  Created by Matej Bukovinski on 29. 06. 16.
//  Copyright © 2016 Matej Bukovinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func showPopover(sender: UIButton) {
        let controller = PopoverViewController()
        let navigationController = UINavigationController(rootViewController: controller)

        navigationController.modalPresentationStyle = .Popover
        let popoverPresentation = navigationController.popoverPresentationController;
        popoverPresentation?.sourceView = sender;
        popoverPresentation?.sourceRect = sender.bounds;

        self.presentViewController(navigationController, animated: true, completion: nil)
    }

}
