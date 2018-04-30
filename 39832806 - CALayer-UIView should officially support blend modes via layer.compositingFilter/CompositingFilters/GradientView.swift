//
//  GradientView.swift
//  CompositingFilters
//
//  Created by Arthur Schiller on 19.11.16.
//  Copyright © 2016 arthurschiller. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    private var colors = [UIColor.white.cgColor, UIColor.black.cgColor]
    
    @IBInspectable var startColor: UIColor = UIColor.white
    @IBInspectable var endColor: UIColor = UIColor.black
    
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0, y: 0)
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1)
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func prepareForInterfaceBuilder() {
        updateView()
    }
    
    override func layoutSubviews() {
        updateView()
    }
    
    private func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.startPoint = startPoint
        layer.endPoint = endPoint
        layer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
