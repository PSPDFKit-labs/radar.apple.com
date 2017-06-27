//
//  Document.swift
//  DocumentBrowserDemo
//
//  Created by Matthias Tretter on 16.06.17.
//  Copyright © 2017 @myell0w. All rights reserved.
//

import UIKit

class Document: UIDocument {

    var text: String = "" {
        didSet {
            self.updateChangeCount(.done)
        }
    }
    
    override func contents(forType typeName: String) throws -> Any {
        return Data(base64Encoded: self.text) ?? Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        guard let contents = contents as? Data else { return }
        guard let string = String(data: contents, encoding: .utf8) else { return }

        self.text = string
    }
}

