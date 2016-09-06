//
//  ViewController.swift
//  CollectionViewBatchingIssue
//
//  Created by Matej Bukovinski on 5. 09. 16.
//  Copyright © 2016 PSPDFKit GmbH. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    // MARK: Lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(2.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            self.updateItems()
        })
    }

    // MARK: - Data

    var items = ["one", "two"]

    private func updateItems() {
        guard let collectionView = collectionView else { return }

        // Potentially triggered from a code segment far, far away for some reason.
        // `items` remains unchanged so one would think this is completely
        // benign. It does however modify the `performBatchUpdates(completion:)`
        // behavior in a way where `UICollectionViewDelegate` calls are queried before
        // the incremental changes are applied, which causes an assertion later on.
        // If we remove this line, the example works fine.
        collectionView.reloadData()

        // As per Collection View Programming Guide for iOS
        // https://developer.apple.com/library/ios/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CreatingCellsandViews/CreatingCellsandViews.html#//apple_ref/doc/uid/TP40012334-CH7-SW7
        // > To insert, delete, or move a single section or item, follow these steps:
        // > Update the data in your data source object.
        // > Call the appropriate method of the collection view to insert or delete the section or item.

        items.append("three")

        // This triggers `UICollectionViewDelegate` methods and asserts at the end
        // because the updated `items.count` is read prematurely.
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: [NSIndexPath(item: 2, section: 0) as IndexPath])
        }, completion: nil)
    }

    // MARK: - UICollectionViewDelegate

    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }
}
