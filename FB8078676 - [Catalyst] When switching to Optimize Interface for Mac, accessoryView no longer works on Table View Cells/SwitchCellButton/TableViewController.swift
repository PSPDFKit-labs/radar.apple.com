//
//  TableViewController.swift
//  SwitchCellButton
//
//  Created by Peter Steinberger on 20.07.20.
//

import UIKit

protocol DefaultReuseIdentifier: class {
    static var defaultReuseIdentifier: String { get }
}

extension DefaultReuseIdentifier {
    @nonobjc
    static var defaultReuseIdentifier: String { return String(describing: type(of: self)) }
}

extension UITableViewCell: DefaultReuseIdentifier {}
extension UICollectionViewCell: DefaultReuseIdentifier {}



class SwitchCell: UITableViewCell {
    let switchView = UISwitch()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        accessoryView = switchView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class TableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(SwitchCell.self, forCellReuseIdentifier: SwitchCell.defaultReuseIdentifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.defaultReuseIdentifier, for: indexPath) as! SwitchCell
        cell.textLabel!.text = "Cell \(indexPath.row)"
        //cell.setup(with: urls[indexPath.row])
        return cell
    }
}
