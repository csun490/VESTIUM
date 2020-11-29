//
//  PhotoCollectionViewCell.swift
//  SlideInTransition
//
//  Created by Cesar Barrera on 11/19/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var highlightedButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func select() {
        
        highlightedButton.isHidden = false
    }
    
    func deSelect() {
        
        highlightedButton.isHidden = true
    }
}
