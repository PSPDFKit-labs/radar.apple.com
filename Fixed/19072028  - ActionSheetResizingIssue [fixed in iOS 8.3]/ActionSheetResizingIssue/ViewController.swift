//
//  ViewController.swift
//  ActionSheetResizingIssue
//
//  Created by Peter Steinberger on 24/11/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)

        sheet.addAction(UIAlertAction(title: "Button 1", style: .Default, handler:nil))
        sheet.addAction(UIAlertAction(title: "Button 2", style: .Default, handler:nil))
        sheet.popoverPresentationController?.sourceView = self.view
        sheet.popoverPresentationController?.sourceRect = CGRectMake(100, 100, 1, 1)
        self.presentViewController(sheet, animated: true) { () -> Void in

            // Show a second alert on top
            let alert = UIAlertController(title: "Radar", message: "The parent action sheet changes size as we show this alert, and it changes itself back to normal as we dismiss it.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay, that's weird", style: .Cancel, handler:nil))
            alert.addTextFieldWithConfigurationHandler(nil)
            sheet.presentViewController(alert, animated: true, completion:nil)
        }
    }
}

