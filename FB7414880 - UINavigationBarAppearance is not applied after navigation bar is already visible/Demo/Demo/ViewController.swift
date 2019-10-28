//
//  ViewController.swift
//  Demo
//
//  Created by Adrian Kashivskyy on 28/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let colors: [UIColor] = [
        .systemRed,
        .systemOrange,
        .systemYellow,
        .systemGreen,
        .systemBlue,
        .systemPurple,
    ]

    private lazy var colorsIterator = colors.makeIterator()

    override func viewDidLoad() {

        super.viewDidLoad()

        navigationItem.title = "Title"
        view.backgroundColor = UIColor.secondarySystemBackground

        let button = UIButton(type: .system)
        button.setTitle("Change color", for: .normal)
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

    }

    @objc func changeColor() {

        guard let navigationBar = navigationController?.navigationBar else {
            return
        }

        guard let color = colorsIterator.next() else {
            colorsIterator = colors.makeIterator()
            return changeColor()
        }

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = color

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance

        // Uncomment the following line to make it work:
        //navigationBar.setNeedsLayout()

    }

}

