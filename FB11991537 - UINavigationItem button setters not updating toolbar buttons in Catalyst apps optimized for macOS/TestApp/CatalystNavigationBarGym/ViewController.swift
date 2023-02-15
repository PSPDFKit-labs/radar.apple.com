import UIKit

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let plainReplaceButton = UIButton(primaryAction: UIAction(title: "Replace Button") { [weak self] _ in
            self?.plainReplaceButton()
        })
        let hackReplaceButtons = UIButton(primaryAction: UIAction(title: "Hack Replace Button") { [weak self] _ in
            self?.hackReplaceButton()
        })

        let contentView = UIStackView(arrangedSubviews: [
            plainReplaceButton,
            hackReplaceButtons
        ])
        contentView.axis = .vertical
        contentView.spacing = 20

        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        navigationItem.rightBarButtonItems = [makeTimestampButton()]
    }

    private func plainReplaceButton() {
        navigationItem.rightBarButtonItems = [makeTimestampButton()]
    }

    private func hackReplaceButton() {
        navigationItem.rightBarButtonItems = []
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItems = [self.makeTimestampButton()]
        }
    }

    private func makeTimestampButton() -> UIBarButtonItem {
        let timestamp = String(describing: Date().timeIntervalSince1970)
        return UIBarButtonItem(title: timestamp, style: .plain, target: nil, action: nil)
    }
}
