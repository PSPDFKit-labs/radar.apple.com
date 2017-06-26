//
//  SearchableViewController.swift
//  SearchBarLayoutIssue
//
//  Created by Stefan Kieleithner on 23/06/2017.
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

import UIKit

class SearchableViewController: UITableViewController {
    var searchController: UISearchController?
    let data = [
        "1. 👆 Tap the search bar",
        "2. ❗️ Notice that the search bar is moved out of the screen.",
        "3. 💻 Comment out the UINavigationBar styling in AppDelegate.swift and run this app again. Everything will work as expected."
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchResultsController = UITableViewController(style: .plain)
        searchResultsController.tableView.dataSource = self
        searchResultsController.tableView.delegate = self

        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController?.delegate = self
        tableView.tableHeaderView = searchController?.searchBar
        definesPresentationContext = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

extension SearchableViewController: UISearchControllerDelegate {

    // Workaround. Uncomment to enable this workaround and position the search bar correctly.
    func setNavigationBarHidden(_ hidden: Bool) {
//        navigationController?.setNavigationBarHidden(hidden, animated: true)
    }

    func willPresentSearchController(_ searchController: UISearchController) {
        setNavigationBarHidden(true)
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        setNavigationBarHidden(false)
    }
}
