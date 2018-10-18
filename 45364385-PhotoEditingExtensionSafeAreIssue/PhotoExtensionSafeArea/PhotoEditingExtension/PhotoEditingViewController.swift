//
//  PhotoEditingViewController.swift
//  PhotoEditingExtension
//
//  Copyright © 2018 PSPDFKit. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class PhotoEditingViewController: UIViewController, PHContentEditingController {

    var input: PHContentEditingInput?
    
    // MARK: - PHContentEditingController
    
    func canHandle(_ adjustmentData: PHAdjustmentData) -> Bool {
        return false
    }
    
    func startContentEditing(with contentEditingInput: PHContentEditingInput, placeholderImage: UIImage) {
        input = contentEditingInput
    }
    
    func finishContentEditing(completionHandler: @escaping ((PHContentEditingOutput?) -> Void)) {
        DispatchQueue.global().async {
            let output = PHContentEditingOutput(contentEditingInput: self.input!)
            completionHandler(output)
        }
    }
    
    var shouldShowCancelConfirmation: Bool {
        return false
    }
    
    func cancelContentEditing() {
    }

}
