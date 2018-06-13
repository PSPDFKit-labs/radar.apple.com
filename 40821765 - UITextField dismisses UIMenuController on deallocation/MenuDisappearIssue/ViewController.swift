//
//  ViewController.swift
//  MenuDisappearIssue
//
//  Created by Peter Steinberger on 13.06.18.
//  Copyright © 2018 Peter Steinberger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.showMenu()
            self.showAndDismissPopover()
        }
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    @objc func randomAction() {
        print("doing stuff")
    }

    func showMenu() {
        self.becomeFirstResponder()

        let menu = UIMenuController.shared
        menu.setTargetRect(CGRect(x: 100, y: 100, width: 10, height: 10), in: self.view)

        let menuItem = UIMenuItem(title: "test", action: #selector(randomAction))
        menu.menuItems = [menuItem]
        menu.setMenuVisible(true, animated: true)
    }

    func showAndDismissPopover() {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        textField.backgroundColor = UIColor.white
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.red
        vc.modalPresentationStyle = .popover
        vc.view.addSubview(textField)
        vc.popoverPresentationController?.sourceView = self.view
        vc.popoverPresentationController?.sourceRect = CGRect(x: 300, y: 300, width: 100, height: 100)
        self.present(vc, animated: true) {
            textField.becomeFirstResponder()
            textField.text = "bla"

            // hacky fix 2 (we call in dealloc)
            //Helper.destroy(textField)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.dismiss(animated: false, completion: nil)

                // uncomment for fix 1
                //DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.showMenu()
                //}
            }
        }
    }

}

