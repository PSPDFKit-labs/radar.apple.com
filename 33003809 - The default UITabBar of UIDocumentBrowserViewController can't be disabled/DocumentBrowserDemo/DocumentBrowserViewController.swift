//
//  DocumentBrowserViewController.swift
//  DocumentBrowserDemo
//
//  Created by Matthias Tretter on 16.06.17.
//  Copyright © 2017 @myell0w. All rights reserved.
//

import Foundation
import UIKit


final class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.allowsDocumentCreation = true
        self.allowsPickingMultipleItems = true
        self.browserUserInterfaceStyle = .white
        self.view.tintColor = .red
        self.customActions = [self.makePresentVersionsAction()]
        self.additionalTrailingNavigationBarButtonItems = [self.makeSettingsItem(), self.makeQuickEntryItem()]
    }
    
    
    // MARK: UIDocumentBrowserViewControllerDelegate
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        if let newDocumentURL = Bundle.main.url(forResource: "Empty", withExtension: "txt") {
            importHandler(newDocumentURL, .move)
        } else {
            importHandler(nil, .none)
        }
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentURLs documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        
        // Present the Document View Controller for the first document that was picked.
        // If you support picking multiple items, make sure you handle them all.
        self.presentDocument(at: sourceURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        // Present the Document View Controller for the new newly created document
        self.presentDocument(at: destinationURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
    }
    
    // MARK: Document Presentation
    
    func presentDocument(at documentURL: URL) {
        let documentViewController = DocumentViewController()
        documentViewController.document = Document(fileURL: documentURL)
        let navigationController = UINavigationController(rootViewController: documentViewController)
        
        self.present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - Actions

private extension DocumentBrowserViewController {

    func showVersions(of urls: [URL]) {
        // TODO: Present a VC that lets the user restore any Version of the document
    }

    @objc
    func handleSettingsPress(_ sender: UIBarButtonItem) {
        // TODO: Present Settings screen
    }

    @objc
    func handleQuickEntryPress(_ sender: UIBarButtonItem) {
        // TODO: Present quick entry input screen
    }
}

// MARK: Factory

private extension DocumentBrowserViewController {

    func makePresentVersionsAction() -> UIDocumentBrowserAction {
        let action = UIDocumentBrowserAction(identifier: "com.myell0w.showVersions",
                                             localizedTitle: Strings.presentVersionsActionTitle,
                                             availability: [.menu, .navigationBar],
                                             handler: self.showVersions)

        action.supportedContentTypes = self.allowedContentTypes
        action.supportsMultipleItems = false

        return action
    }

    func makeSettingsItem() -> UIBarButtonItem {
        let item = UIBarButtonItem(image: #imageLiteral(resourceName: "Settings"), style: .plain, target: self, action: #selector(handleSettingsPress(_:)))
        item.accessibilityLabel = Strings.Accessibility.settingsLabel
        return item
    }

    func makeQuickEntryItem() -> UIBarButtonItem {
        let item = UIBarButtonItem(image: #imageLiteral(resourceName: "MNQuickEntry"), style: .plain, target: self, action: #selector(handleQuickEntryPress(_:)))
        item.accessibilityLabel = Strings.Accessibility.quickEntryLabel
        item.accessibilityHint = Strings.Accessibility.quickEntryHint
        return item
    }

    struct Strings {
        static let presentVersionsActionTitle = NSLocalizedString("Browse Versions…", comment: "Document Browser Action for a Document")

        struct Accessibility {
            static let settingsLabel = NSLocalizedString("Settings", comment: "Accessibility Label for button to present the settings screen")
            static let quickEntryLabel = NSLocalizedString("Brainstorm", comment: "Accessibility Label for button used to start quick entry mode")
            static let quickEntryHint = NSLocalizedString("Shows an input field to enter a freeform text outline.", comment: "Accessibility Hint for button used to start quick entry mode")
        }
    }
}

