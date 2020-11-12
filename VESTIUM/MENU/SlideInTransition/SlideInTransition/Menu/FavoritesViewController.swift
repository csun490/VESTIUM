
//  FavoritesViewController.swift
//  SlideInTransition
//
//  Created by CSUN-Vestium  on 10/6/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import SwiftUI
import UIKit

class FavoritesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var shirtImage: UIImageView!
    @IBOutlet weak var pantsImage: UIImageView!
    @IBOutlet weak var shoeImage: UIImageView!
    var imagePicked = 0
    
    @IBAction func tshirtButton(_ sender: UIButton) {
        imagePicked = 1
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = true
        image.accessibilityRespondsToUserInteraction = true
        self.present(image, animated: true)
    }
    
    @IBAction func pantsButton(_ sender: UIButton) {
        imagePicked = 2
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = true
        image.accessibilityRespondsToUserInteraction = true
        self.present(image, animated: true)
    }
    
    @IBAction func shoeButton(_ sender: UIButton) {
        imagePicked = 3
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = true
        image.accessibilityRespondsToUserInteraction = true
        self.present(image, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additionl setup after loading the view.
    }
    
    // photo library button
    @IBAction func photoLibraryButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    // cancel button in photo library
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage { // check image
                if imagePicked == 1{
                    shirtImage.image = image
                } else if imagePicked == 2 {
                    pantsImage.image = image
                } else if imagePicked == 3 {
                    shoeImage.image = image
                } else {
                    print("something went wrong")
                }
           }else {
            print("something went wrong")
           }
    self.dismiss(animated: true, completion: nil)
    }
}
    
    

