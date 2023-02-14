//
//  ViewController.swift
//  ZoomedTextViewExample
//
//  Created by Daniel Langh on 2023. 02. 09..
//

import UIKit

/**
Example demonstrating blurred selection handles when zooming in on a `UITextView` embedded inside a `UIScrollView`.
To keep the `UITextView` crisp you can adjust the `contentScaleFactor` property of the text view and it's subviews,
however that won't affect the selection handles.

Steps to reproduce:
- Use the pinch gesture to zoom in on this text view
- Double tap to select text
- Observe the selection dragger dots being blurred

Please see the attached `blurred.png` to see the blurred handles.
 */

class ViewController: UIViewController {

    /// The scroll view to used for zooming.
    var scrollView: UIScrollView!

    /// The content view of the scrollview.
    var contentView: UIView!

    /// Text view to demonstrate the blurred selection handles.
    var textView: UITextView!

    /// Label for the demonstration image.
    var label: UILabel!

    /// Image view to present the inspected result.
    var imageView: UIImageView!

    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.delegate = self
        scrollView.maximumZoomScale = 20
        scrollView.minimumZoomScale = 1
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scrollView)

        contentView = UIView()
        contentView.frame = CGRect(x: 0, y: 0, width: 3000, height: 3000)
        scrollView.addSubview(contentView)

        textView = UITextView(frame: CGRect(x: 50, y: 50, width: 400, height: 200))
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        textView.backgroundColor = UIColor.lightGray
        contentView.addSubview(textView)

        textView.text = "Steps to reproduce:\n- Use the pinch gesture to zoom in on this text view\n- Double tap to select text\n- Observe the selection dragger dots being blurred"

        label = UILabel(frame: CGRect(x: 50, y: 300, width: 200, height: 30))
        label.text = "Result:"
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(label)

        imageView = UIImageView(image: UIImage(named: "blurred.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        imageView.frame = CGRect(x: 50, y: 350, width: 200, height: 100)
        contentView.addSubview(imageView)
    }

}

// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        contentView
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        let clampedScale = max(1, scale) * traitCollection.displayScale
        textView.setContentScaleFactorRecursively(clampedScale)
        label.setContentScaleFactorRecursively(clampedScale)
    }

}

// MARK: - Helper

extension UIView {

    func setContentScaleFactorRecursively(_ scale: CGFloat) {
        contentScaleFactor = scale
        for subview in subviews {
            subview.setContentScaleFactorRecursively(scale)
        }
    }

}
