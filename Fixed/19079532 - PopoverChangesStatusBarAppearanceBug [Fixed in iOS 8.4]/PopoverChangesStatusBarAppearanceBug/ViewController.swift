//
//  ViewController.swift
//  PopoverChangesStatusBarAppearanceBug
//
//  Created by Peter Steinberger on 25/11/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var displayed = false

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            if (!self.displayed) {
                let picker = UIImagePickerController()
                picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                picker.modalPresentationStyle = UIModalPresentationStyle.Popover

                picker.popoverPresentationController?.sourceView = self.view
                picker.popoverPresentationController?.sourceRect = CGRectMake(100, 100, 1, 1)
                self.presentViewController(picker, animated: true) {

                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                        let alert = UIAlertController(title: "Radar", message: "Observe that the status bar changed (which it should not) and that after dismissing the popover, it stays that way (which again, it shouldn't).\n\nThe alert view doesn't change the status bar, but you can disable the presentation to verify that.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil))
                    picker.presentViewController(alert, animated: true, completion: nil)
                    }
                }
                self.displayed = true
            }
        };
    }
}

