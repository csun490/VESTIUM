//
//  CollectionViewCell.swift
//  SlideInTransition
//
//  Created by Mimi  on 10/22/20.
//  Copyright © 2020 Murat Bekgi. All rights reserved.
//

import UIKit

import UIKit
class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    
    var cellImageName:String?
    class var CustomCell : CustomCollectionViewCell {
        let cell = Bundle.main.loadNibNamed("CustomCollectionViewCell", owner: self, options: nil)?.last
        return cell as! CustomCollectionViewCell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.backgroundColor = UIColor.black
        
    }
    
    func updateCellWithImage(name:String) {
        self.cellImageName = name
        self.cellImageView.image = UIImage(named: name)
    }
    
}
