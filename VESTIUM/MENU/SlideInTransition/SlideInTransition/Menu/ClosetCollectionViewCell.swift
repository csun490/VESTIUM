//
//  ClosetCollectionViewCell.swift
//  SlideInTransition
//
//  Created by Mimi  on 9/29/20.
//  Copyright © 2020 Murat Bekgi. All rights reserved.
//

import UIKit

class ClosetCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    static let identifier = "ClosetCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // returns a reusable cell
    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    // registers our collectionView to a cell,
    // tells collecView a cell is created to be used
    static func nib() -> UINib {
        return UINib(nibName: "ClosetCollectionViewCell", bundle: nil)
    }

}
