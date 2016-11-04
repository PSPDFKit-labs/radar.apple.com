//
//  ViewController.swift
//  BlankSafariViewController
//
//  Created by Robert Wijas on 04/11/2016.
//  Copyright © 2016 PSPDFKit. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    lazy var svc = SFSafariViewController(url: URL(string: "https://pdfviewer.io")!)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Creates controller during presentation but before beeing added to window.
        let _ = svc // Comment out this line to fix.
    }

    @IBAction func present(_ sender: Any) {
        svc.modalPresentationStyle = .fullScreen
        present(svc, animated: true, completion: nil)
    }

}
