//
//  ViewController.swift
//  SwiftUITabViewIssue
//
//  Created by Stefan Kieleithner on 18.12.24.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function + " called")
        addLabel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(#function + " called")
        if parent == nil {
            // The parent is `nil` when contained in a TabView with .tabViewStyle(.page) style
            print("View controller containment and view lifecycle methods are not called. Parent is nil.")
        } else {
            print("Parent: " + String(describing: parent))
        }
    }

    // !!!!!!!
    // None of the following view controller containment and view lifecycle methods
    // are being called when in a TabView with .tabViewStyle(.page) style
    // !!!!!!!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function + " called")
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print(#function + " called")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function + " called")
    }

    override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()
        print(#function + " called")
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        print(#function + " called")
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        print(#function + " called")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function + " called")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function + " called")
    }
}

extension ViewController {
    func addLabel() {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Look at ViewController.swift and in the console to see that view lifecycle methods are not being called."
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
