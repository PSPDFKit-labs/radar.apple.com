//
//  Models.swift
//  Gallery
//
//  Copyright © 2019 Apple, Inc. All rights reserved.
//

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A file that defines our data models (Photo and PhotoSection).
*/

import UIKit

let GalleryOpenDetailActivityType       = "com.apple.gallery.openDetail"
let GalleryOpenDetailPath               = "openDetail"
let GalleryOpenDetailPhotoIdKey         = "photoId"

public struct Photo {
    let name: String
    
    var openDetailUserActivity: NSUserActivity {
        // Create an NSUserActivity from our photo model.
        // Note: The activityType string below must be included in your Info.plist file under the `NSUserActivityTypes` array.
        // More info: https://developer.apple.com/documentation/foundation/nsuseractivity
        let userActivity = NSUserActivity(activityType: GalleryOpenDetailActivityType)
        userActivity.title = GalleryOpenDetailPath
        userActivity.userInfo = [GalleryOpenDetailPhotoIdKey: name]
        return userActivity
    }

}

struct PhotoSection {
    let name: String
    let photos: [Photo]
}

struct PhotoManager {
    static let shared = PhotoManager()
    
    let sections: [PhotoSection] = [
        PhotoSection(name: "Section 1", photos: [
            Photo(name: "1.jpg"),
            Photo(name: "2.jpg")
        ]),
        PhotoSection(name: "Section 2", photos: [
            Photo(name: "3.jpg"),
        ]),
        PhotoSection(name: "Section 3", photos: [
            Photo(name: "4.jpg"),
        ])
    ]
}

