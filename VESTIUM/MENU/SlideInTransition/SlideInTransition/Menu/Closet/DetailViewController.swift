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
    

    @IBOutlet weak var donateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViewControllerWithDetails()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
 
    @objc func saveTapped(_ sender: AnyObject) {
      dismiss(animated: true, completion: nil)
    }

    
    @IBAction func laundryButton(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            detailImageView.alpha = 1
        } else {
            sender.isSelected = true
            detailImageView.alpha = 0.2
        }
    }
    
    @IBAction func donateButton(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    

    func updateViewControllerWithDetails() {
        if let selCategory = self.category, let imageTitle = self.imageName {
            self.descriptionLabel.text = selCategory.catDescription
            self.detailImageView.image = UIImage(named: imageTitle)
        }
    }
    
}
