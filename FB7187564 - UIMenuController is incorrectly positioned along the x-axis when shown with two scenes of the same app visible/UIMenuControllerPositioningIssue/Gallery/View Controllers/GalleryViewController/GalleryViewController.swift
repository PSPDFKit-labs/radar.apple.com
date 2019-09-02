//
//  ViewController.swift
//  Gallery
//
//  Copyright © 2019 Apple, Inc. All rights reserved.
//

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view controller that displays a collection of photos.
 It also shows how to create a new scene session via Drag and Drop.
*/

import UIKit

class GalleryViewController: UIViewController {
    
    // IBOutlets
    
    @IBOutlet weak private var galleryCollectionView: UICollectionView!
    
    // Data
    
    let photoSections = PhotoManager.shared.sections
    
    // View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Gallery"

        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        galleryCollectionView.dragDelegate = self
        galleryCollectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    func photo(at indexPath: IndexPath) -> Photo {
        return photoSections[indexPath.section].photos[indexPath.row]
    }

}

extension GalleryViewController: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let selectedPhoto = photo(at: indexPath)

        let userActivity = selectedPhoto.openDetailUserActivity
        let itemProvider = NSItemProvider(object: UIImage(named: selectedPhoto.name)!)
        itemProvider.registerObject(userActivity, visibility: .all)

        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = selectedPhoto
        
        return [dragItem]
    }

}

extension GalleryViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        let menu = UIMenuController.shared
        cell.becomeFirstResponder()

        let menuItems = [UIMenuItem(title: "Test", action: #selector(action))]
        menu.menuItems = menuItems
        menu.showMenu(from: collectionView, rect: cell.frame)
    }

    @objc func action() { }
}

extension GalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photoSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoSections[section].photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        if let cell = cell as? GalleryCollectionViewCell {
            let selectedPhoto = photo(at: indexPath)
            cell.image = UIImage(named: selectedPhoto.name)
        }
        
        return cell
    }

}
