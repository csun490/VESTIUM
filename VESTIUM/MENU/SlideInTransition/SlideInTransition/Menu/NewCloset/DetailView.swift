//
//  DetailViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 4/22/21.
//  Copyright © 2021 CSUN-Vestium. All rights reserved.
//

import UIKit

class DetailView : UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        navigationController?.setToolbarHidden(false, animated: true)
        
        imageView.image = image
        navigationItem.title = "Closet"
     
    }
    
    @objc func saveTapped(_ sender: AnyObject) {
      dismiss(animated: true, completion: nil)
    }

    
    @IBAction func laundryDidTap(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            imageView.alpha = 1
        } else {
            sender.isSelected = true
            imageView.alpha = 0.2
        }
    }
    
    @IBAction func donateDidTap(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
}

@IBAction func nextButton(_ sender: Any) {
    self.performSegue(withIdentifier: "closetSegue", sender: nil)
    delegate?.updatePhoto(image: self.filterPhoto.image!)
}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier ==  "closetSegue" {
        let closetImageVC = segue.destination as! PhotoCollectionViewController
        closetImageVC.filteredImage = self.filterPhoto.image
    }
}
