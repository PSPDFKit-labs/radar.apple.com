import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        self.window = window
        window.rootViewController = UINavigationController(rootViewController: TableViewController())
        window.makeKeyAndVisible()
        return true
    }
}

class TableViewController: UITableViewController {
    let reuseIdentifier = "e"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CustomCell
        cell.customLabel.text = "To match the layout of the built-in cells, you should use the cell’s layout margins, not the content view’s layout margins."
        return cell
    }
}

class CustomCell: UITableViewCell {
    let customLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        customLabel.numberOfLines = 0
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customLabel)

        let margins = layoutMarginsGuide
        NSLayoutConstraint.activate([
            customLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0),
            customLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0),
            margins.trailingAnchor.constraint(equalTo: customLabel.trailingAnchor, constant: 0),
            margins.bottomAnchor.constraint(equalTo: customLabel.bottomAnchor, constant: 0),
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
