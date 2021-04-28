//
//  Photo.swift
//  SlideInTransition
//
//  Created by Mimi  on 4/22/21.
//  Copyright © 2021 CSUN-Vestium. All rights reserved.
//

import Foundation

struct PhotoCategory {
    var categoryImageName: String
    var title: String
    var imageNames: [String]
}

class PhotosLibrary {
    class func fetchPhotos() -> [PhotoCategory] {
        var categories = [PhotoCategory]()
        let photosData = PhotosLibrary.downloadPhotosData()
        
        for (categoryTitle, dict) in photosData {
            if let dict = dict as? [String : Any] {
                let categoryImageName = dict["categoryImageName"] as! String
                if let imageNames = dict["imageNames"] as? [String] {
                    let newCategory = PhotoCategory(categoryImageName: categoryImageName, title: categoryTitle, imageNames: imageNames)
                    
                    categories.append(newCategory)
                }
            }
        }
        
        return categories
    }
    
    class func downloadPhotosData() -> [String : Any] {
        return [
            "Head" : [
                "categoryImageName" : "hat",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "h", numberOfImages: 7),
            ],
            "Top-Inner" : [
                "categoryImageName" : "tshirt",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "ti", numberOfImages: 6),
            ],
            "Top-Mid" : [
                "categoryImageName" : "shirts",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "tm", numberOfImages: 6),
            ],
            "Top-Outer" : [
                "categoryImageName" : "jacket",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "to", numberOfImages: 6),
            ],
            "Bottom" : [
                "categoryImageName" : "jeans",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "b", numberOfImages: 6),
            ],
            "Feet" : [
                "categoryImageName" : "sneakers",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "f", numberOfImages: 6),
            ],
            "Other" : [
                "categoryImageName" : "watch",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "o", numberOfImages: 6),
            ]
        ]
    }
    
    private class func generateImage(categoryPrefix: String, numberOfImages: Int) -> [String] {
        var imageNames = [String]()
        
        for i in 1...numberOfImages {
            imageNames.append("\(categoryPrefix)\(i)")
        }
        
        return imageNames
    }
}















