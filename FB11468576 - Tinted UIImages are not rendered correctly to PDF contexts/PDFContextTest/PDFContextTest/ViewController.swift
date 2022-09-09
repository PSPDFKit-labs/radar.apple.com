//
//  ViewController.swift
//  PDFContextTest
//
//  Created by rumori on 2022. 09. 07..
//

import UIKit
import PDFKit

/*
 Image assets with template rendering mode or tinted `UIImage` objects are not rendered correctly to PDF contexts.
 Instead of properly tinting the image and having the original shape intact, these render as a colored rectangle to the
 PDF context. The rectangle size is equal to the bounding box of the original image.
 
 This class demonstrates the different issues with rendering tinted images.
 */
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment each of the below lines to see the rendering results.
        
        // Image with Default rendering mode untinted. Works as expected - good
        //displayPDFWithImage(UIImage(named: "note-comment")!)
        
        // Image with Default rendering mode tinted. Renders as a red rectangle instead of the shape - not good
        displayPDFWithImage(UIImage(named: "note-comment")!.withTintColor(UIColor.red, renderingMode: .alwaysOriginal))
        
        // Image with Template rendering mode untinted. Renders as a black rectangle instead of the shape - not good
        //displayPDFWithImage(UIImage(named: "note-comment-template")!)
        
        // Image with Template rendering mode tinted. Renders as a red rectangle instead of the shape - not good
        //displayPDFWithImage(UIImage(named: "note-comment-template")!.withTintColor(UIColor.red, renderingMode: .alwaysOriginal))
    }
    
    func displayPDFWithImage(_ image: UIImage) {

        let bounds = CGRect(x: 0, y: 0, width: 500, height: 500)
        let data = NSMutableData()
        UIGraphicsBeginPDFContextToData(data, bounds, nil)


        let pdfContext = UIGraphicsGetCurrentContext()!

        pdfContext.beginPDFPage(nil)

        let pageSize = UIGraphicsGetPDFContextBounds().size
        pdfContext.translateBy(x: 0, y: pageSize.height)
        pdfContext.scaleBy(x: 1, y: -1)

        UIGraphicsPushContext(pdfContext)
        image.draw(in: CGRect(x: 50, y: 50, width: 100, height: 100))
        UIGraphicsPopContext()

        pdfContext.endPDFPage()
        UIGraphicsEndPDFContext()

        let view = PDFView(frame: self.view.bounds)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.document = PDFDocument(data: data as Data)
        self.view.addSubview(view)
    }
}
