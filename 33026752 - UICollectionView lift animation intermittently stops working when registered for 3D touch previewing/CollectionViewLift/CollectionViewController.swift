//
//  CollectionViewController.swift
//  CollectionViewLift
//
//  Created by Aditya Krishnadevan on 15/06/2017.
//  Copyright © 2017 caughtinflux. All rights reserved.
//

import UIKit
import MobileCoreServices

class CollectionViewController: UICollectionViewController, UIViewControllerPreviewingDelegate, UICollectionViewDragDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("Collectionview does not have a flow layout")
        }

        layout.itemSize = CGSize(width: 200, height: 200)

        registerForPreviewing(with: self, sourceView: collectionView!)
        collectionView!.dragDelegate = self
    }

    // Data Source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVC", for: indexPath)
        cell.contentView.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        return cell
    }

    // Previewing
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let viewController = UIViewController()
        viewController.view.frame.size = CGSize(width: 100, height: 200)
        viewController.view.backgroundColor = UIColor.red
        return viewController
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        present(viewControllerToCommit, animated: true, completion: nil)
    }

    // Drag Delegate
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider(item: "This Is Some Text" as NSString, typeIdentifier: String(kUTTypePlainText))
        let dragItem = UIDragItem(itemProvider: itemProvider)

        return [dragItem]
    }
}

class LiftCell: UICollectionViewCell {

    let privateContentView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        privateContentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        privateContentView.frame = super.contentView.frame
        super.contentView.addSubview(privateContentView)
        super.contentView.backgroundColor = UIColor.blue
    }

    override var contentView: UIView {
        return privateContentView
    }
}

