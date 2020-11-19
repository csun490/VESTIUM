//
//  TagImageViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/18/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit
import TTGTagCollectionView

class TagImageViewController: UIViewController, TTGTextTagCollectionViewDelegate {

    var selectedImage: UIImage?
    let collectionView = TTGTextTagCollectionView()
    
    private var selections = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.alignment = .left
        collectionView.delegate = self
        view.addSubview(collectionView)

        let body = TTGTextTagConfig()
        body.backgroundColor = .white
        body.textColor = .black
       
        collectionView.addTags(["Head", "Top-Inner", "Top-Mid", "Top-Outer", "Bottom", "Feet", "Other"], with: body)
        
        let season = TTGTextTagConfig()
        //body.backgroundColor = .white
        season.textColor = .black
        collectionView.addTags(["Spring", "Summer", "Fall", "Winter"], with: season)
      
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 100 , width: view.frame.size.width, height: view.frame.size.height)
    }
    
    // append selection tags in array
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool, tagConfig config: TTGTextTagConfig!) {
        selections.append(tagText)
        print("\(selections)")
    }

}

extension TagImageViewController: FilterViewControllerDelegate {
    func updatePhoto(image: UIImage) {
        //self.selectedImage.image = image
    }
}
