//
//  ViewController.swift
//  SearchControllerDeallocIssue
//
//  Created by Peter Steinberger on 29.10.20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .system)
        button.setTitle("Tap Me", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        button.sizeToFit()
        view.addSubview(button)
        button.center = view.center
    }

    @objc func tapped(_ sender: AnyObject?) {
        let tvc = TableViewController()
        let navc = NavigationController(rootViewController: tvc)
        navc.modalPresentationStyle = .popover

        let pop = navc.popoverPresentationController
        pop?.sourceView = sender as? UIView
        self.present(navc, animated: true)
    }
}

// empty subclass for memory debugger
class NavigationController: UINavigationController {}

class TableViewController: UITableViewController {
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // If this is NOT set, deallocation works, but this causes other bugs.
        self.definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // uncomment to fix
        //searchController.dismiss(animated: false, completion: nil)
    }

    deinit {
        // This is NOT printed if you present the popover, tap on the search field and then dismiss the popover.
        // If search is deactivated inside the popover (cancel) then this is called
        print("Deallocated!")
    }
}
