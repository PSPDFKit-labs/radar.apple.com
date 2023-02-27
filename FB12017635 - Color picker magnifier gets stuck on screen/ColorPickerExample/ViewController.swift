//
//  ViewController.swift
//  ColorPickerExample
//
//  Created by Daniel Langh on 2023. 02. 27..
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let colorPicker = UIColorPickerViewController()

        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.text = "Issue: color picker magnifier getting permanently stuck on the screen\n\nSteps to reproduce (note that you will have to restart your device to get back to normal afterwards):\n1. Tap and hold the color sampling tool in the Color picker toolbar\n2. Drag your finger without lifting it\n3. Lift your finger outside of the color sampling tool button\n4. Repeat steps 1-3 multiple times until the color picker magnifier stays permanently on the screen\n5. Observe the color picker magnifier not disappearing\n6. Observe not being able to press any buttons as long as the color magnifier is stuck on the screen"
        label.numberOfLines = 0
        label.frame = CGRect(x: 50, y: view.bounds.height / 2 - 50, width: view.bounds.width - 100, height: view.bounds.height / 2)
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(label)

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(colorPicker.view)
        stackView.addArrangedSubview(label)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        view.addConstraints([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        stackView.frame = view.bounds.insetBy(dx: 100, dy: 50)

        addChild(colorPicker)
        colorPicker.didMove(toParent: self)
    }
}

