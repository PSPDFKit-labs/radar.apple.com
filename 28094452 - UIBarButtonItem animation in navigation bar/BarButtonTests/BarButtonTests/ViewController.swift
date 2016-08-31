//
//  ViewController.swift
//  BarButtonTests
//
//  Created by Aditya Krishnadevan on 31/08/16.
//  Copyright © 2016 caughtinflux. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var defaultItems: [UIBarButtonItem]!
    var toggledItems: [UIBarButtonItem]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        defaultItems = [UIBarButtonItem.withRandomlyColoredImage(), UIBarButtonItem.withRandomlyColoredImage(), UIBarButtonItem.withRandomlyColoredImage()]
        toggledItems = [UIBarButtonItem.withRandomlyColoredImage(), UIBarButtonItem.withRedCustomView(), UIBarButtonItem.withRandomlyColoredImage()]
        navigationItem.setRightBarButtonItems(defaultItems, animated: false)
    }

    @IBAction func toggle(_ sender: UIButton) {
        let newItems = navigationItem.rightBarButtonItems! == defaultItems ? toggledItems : defaultItems
        navigationItem.setRightBarButtonItems(newItems, animated: true)
    }
}


extension UIBarButtonItem {
    static func withRedCustomView() -> UIBarButtonItem {
        let customView = UIView()
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        customView.backgroundColor = UIColor.red
        customView.frame = CGRect(x: 0, y: 0, width: 20, height: 30)
        let item = UIBarButtonItem(customView: customView)
        return item
    }

    static func withRandomlyColoredImage() -> UIBarButtonItem {
        let image = UIColor.random.imageWith(CGSize(width: 20, height: 30))
        return UIBarButtonItem(image: image, landscapeImagePhone: nil, style: .plain, target: nil, action: nil)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
    }

    func imageWith(_ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        setFill()
        UIGraphicsGetCurrentContext()!.fill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image.withRenderingMode(.alwaysOriginal)
    }
}
