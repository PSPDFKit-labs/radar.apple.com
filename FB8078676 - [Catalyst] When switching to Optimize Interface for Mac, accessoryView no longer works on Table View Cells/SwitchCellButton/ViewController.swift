//
//  ViewController.swift
//  SwitchCellButton
//
//  Created by Peter Steinberger on 20.07.20.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            let tableVC = TableViewController()
            self.present(tableVC, animated: false, completion: nil)
        }
    }

}

