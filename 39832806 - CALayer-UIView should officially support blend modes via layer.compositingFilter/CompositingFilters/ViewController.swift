//
//  ViewController.swift
//  CompositingFilters
//
//  Created by Arthur Schiller on 16.11.16.
//  Copyright © 2016 arthurschiller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: View Outlets
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var selectedCompositeFilterLabel: UILabel!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var compositeFilterPickerView: UIPickerView!
    
    // MARK: Constraint Outlets
    @IBOutlet weak var pickerContainerViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    let compositingFilterStrings = [
        "normalBlendMode",
        //
        "darkenBlendMode",
        "multiplyBlendMode",
        "colorBurnBlendMode",
        //
        "lightenBlendMode",
        "screenBlendMode",
        "colorDodgeBlendMode",
        //
        "overlayBlendMode",
        "softLightBlendMode",
        "hardLightBlendMode",
        //
        "differenceBlendMode",
        "exclusionBlendMode",
        //
        /*
        "hueBlendMode",
        "saturationBlendMode",
        "colorBlendMode",
        "luminosityBlendMode",
         */
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        togglePickerContainerView(show: false, animated: false)
        setCompositeFilter(index: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        topImageView.layer.cornerRadius = topImageView.bounds.width / 2
    }
    
    func setCompositeFilter(index: Int) {
        
        let filterString = compositingFilterStrings[index]
        print(filterString)
        
        topImageView.superview!.layer.compositingFilter = filterString
        topImageView.layer.compositingFilter = "normalBlendMode"
        selectedCompositeFilterLabel.text = "Selected Filter: »\(filterString)«"
    }
    
    func togglePickerContainerView(show: Bool, animated: Bool) {
        
        if animated {
            
            UIView.animate(withDuration: show ? 0.6 : 0.7, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.55, options: [], animations: {
                
                self.pickerContainerView.alpha = show ? 1 : 0
                self.pickerContainerViewBottomConstraint.constant = show ? 0 : -self.pickerContainerView.bounds.height
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            pickerContainerView.alpha = show ? 1 : 0
            pickerContainerViewBottomConstraint.constant = show ? 0 : -pickerContainerView.bounds.height
        }
    }
}

extension ViewController {
    
    // MARK: Handler for button taps
    @IBAction func openPickerViewButtonWasPressed(_ sender: Any) {
        togglePickerContainerView(show: true, animated: true)
    }
    
    @IBAction func closePickerViewButtonWasPressed(_ sender: Any) {
        togglePickerContainerView(show: false, animated: true)
    }
    
    // MARK: Handler for gesture recognizers
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @IBAction func handlePinch(recognizer : UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    @IBAction func handleRotate(recognizer : UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return compositingFilterStrings.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return compositingFilterStrings[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        setCompositeFilter(index: row)
    }
    
}
