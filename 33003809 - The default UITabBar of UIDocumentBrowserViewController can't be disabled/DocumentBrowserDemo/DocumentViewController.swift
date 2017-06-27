//
//  DocumentViewController.swift
//  DocumentBrowserDemo
//
//  Created by Matthias Tretter on 16.06.17.
//  Copyright © 2017 @myell0w. All rights reserved.
//

import UIKit

final class DocumentViewController: UIViewController {
    
    var document: Document?
    private let textView = UITextView()
    private let dismissButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDocumentViewController))

    override func viewDidLoad() {
        super.viewDidLoad()

        self.textView.frame = self.view.bounds
        self.textView.backgroundColor = .white
        self.textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(self.textView)
        self.navigationItem.rightBarButtonItem = self.dismissButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.document?.open(completionHandler: { success in
            if success {
                self.title = self.document?.fileURL.lastPathComponent
                self.textView.text = self.document?.text
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }

    @objc
    func dismissDocumentViewController() {
        self.document?.text = self.textView.text
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
}
