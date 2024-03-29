//
//  ViewController.swift
//  ActionSheetCatalystIssue
//
//  Created by Peter Steinberger on 30.09.19.
//  Copyright © 2019 PSPDFKit GmbH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let vc = UIViewController()
        let button = UIButton()
        button.setTitle("Tap to show ActionSheet", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        button.sizeToFit()

        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(button)

        let button2 = UIButton()
        button2.setTitle("Simple Alert", for: .normal)
        button2.setTitleColor(UIColor.blue, for: .normal)
        button2.addTarget(self, action: #selector(alertPressed), for: .touchUpInside)
        stack.addArrangedSubview(button2)

        vc.view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true

        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: false, completion: nil)
    }

    @objc func pressed(sender: UIButton!) {
        let alertController = UIAlertController(title: "Bug Test", message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Action One", style: .default) { action in
            print("Action 1 pressed: \(action)")
        }
        alertController.addAction(action1)
        let action2 = UIAlertAction(title: "Action Two", style: .default) { action in
            print("Action 2 pressed: \(action)")
        }
        alertController.addAction(action2)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("Cancel pressed: \(action)")
        }
        alertController.addAction(cancelAction)

        self.presentedViewController?.present(alertController, animated: false) {
            print("Presented")
        }
    }

    @objc func alertPressed(sender: UIButton!) {
        let alertController = UIAlertController(title: "Bug Test", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("Cancel pressed: \(action)")
        }
        alertController.addAction(cancelAction)

        self.presentedViewController?.present(alertController, animated: false) {
            print("Presented")
        }
    }

}

