//
//  ViewController.swift
//  PopoverPlayground
//
//  Created by Akshat Patel on 12/24/19.
//  Copyright © 2019 akshat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var textField: UITextField!

    var accessory: UIView!
    var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        accessory = UIView(frame: .zero)
        accessory.backgroundColor = .lightGray
        accessory.alpha = 0.6

        button = UIButton(type: .custom)
        button.setTitle("Button", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        self.setupConstraints()
    }

    func setupConstraints() {
        textField.inputAccessoryView = accessory
        accessory.addSubview(button)

        accessory.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        accessory.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo:accessory.leadingAnchor, constant: 20),
            button.centerYAnchor.constraint(equalTo:accessory.centerYAnchor),
            button.trailingAnchor.constraint(equalTo:accessory.trailingAnchor, constant: -20)
        ])
    }

    @objc func buttonTapped() {
        let tableVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableViewController")
        tableVC.modalPresentationStyle = .popover
        tableVC.popoverPresentationController!.delegate = self
        present(tableVC, animated: true, completion:nil)
    }

    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.sourceView = button
        popoverPresentationController.sourceRect = button.bounds
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}
