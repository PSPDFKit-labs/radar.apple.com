//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Stefan Kieleithner on 01/03/2017.
//  Copyright © 2017 PSPDFKit. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {

    @IBAction func insertButtonTapped(_ sender: Any) {
        self.activeConversation?.insertAttachment(Bundle.main.bundleURL.appendingPathComponent("Document.pdf"), withAlternateFilename: "AlternateDocument")
    }
}
