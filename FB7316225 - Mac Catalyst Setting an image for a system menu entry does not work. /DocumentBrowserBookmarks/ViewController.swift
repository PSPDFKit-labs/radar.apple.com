//
//  ViewController.swift
//  DocumentBrowserBookmarks
//
//  Created by Peter Steinberger on 23.09.19.
//  Copyright © 2019 PSPDFKit GmbH. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.alignment = .leading
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10).isActive = true

        let button = UIButton()
        button.setTitle("Open URL", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(imageView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)

        loadLastRecentFile()
    }

    @objc public func loadLastRecentFile() {
        // Try to load bookmark
        let recentFiles = (UIApplication.shared.delegate as! AppDelegate).getRecentFiles()
        guard let lastRecentFile = recentFiles.last else { return }
        loadImageFromURL(lastRecentFile)
    }

    @objc private func didTapButton(_ sender: UIButton) {
        let controller = UIDocumentPickerViewController(documentTypes: [(kUTTypeImage as String)], in: .open)
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)

    }
}

extension ViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        (UIApplication.shared.delegate as! AppDelegate).registerRecentFile(url)
        loadImageFromURL(url)
    }

    func loadImageFromURL(_ url: URL) {
        guard url.startAccessingSecurityScopedResource() else {
            print("Calling startAccessingSecurityScopedResource() on \(url) failed.")
            return
        }
        do {
            let data = try Data(contentsOf: url, options: [])
            let image = UIImage(data: data)
            imageView.image = image
        } catch {
            print("Error while loading: \(error)")
        }
        url.stopAccessingSecurityScopedResource()
    }
}
