//
//  DetailsViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 10/22/20.
//  Copyright © 2020 Murat Bekgi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var category: ImageCategory?
    var imageName: String?
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Closet"
        self.updateViewControllerWithDetails()
    }
    
    func updateViewControllerWithDetails() {
        if let selCategory = self.category, let imageTitle = self.imageName {
            self.descriptionLabel.text = selCategory.catDescription
            self.detailImageView.image = UIImage(named: imageTitle)
        }
    }
    
}
