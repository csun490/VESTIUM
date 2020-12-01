
//  FavoritesViewController.swift
//  SlideInTransition
//
//  Created by CSUN-Vestium  on 10/6/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import SwiftUI
import UIKit

class FavoritesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // image view for items
    @IBOutlet weak var shirtImage: UIImageView!
    @IBOutlet weak var pantsImage: UIImageView!
    @IBOutlet weak var shoeImage: UIImageView!
    @IBOutlet weak var misc1Image: UIImageView!
    @IBOutlet weak var misc2Image: UIImageView!
    
    // red add buttons
    @IBOutlet weak var tshirtAdd: UIButton!
    @IBOutlet weak var pantsAdd: UIButton!
    @IBOutlet weak var shoesAdd: UIButton!
    @IBOutlet weak var misc1Add: UIButton!
    @IBOutlet weak var misc2Add: UIButton!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    var imagePicked = 0
    
    @IBAction func tshirtButton(_ sender: UIButton) {
        imagePicked = 1
        handleImagePost()
    }
    
    @IBAction func pantsButton(_ sender: UIButton) {
        imagePicked = 2
        handleImagePost()
    }
    
    @IBAction func shoeButton(_ sender: UIButton) {
        imagePicked = 3
        handleImagePost()
    }
    
    @IBAction func misc1Button(_ sender: Any) {
        imagePicked = 4
        handleImagePost()
    }
    
    @IBAction func misc2Button(_ sender: Any) {
        imagePicked = 5
        handleImagePost()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additionl setup after loading the view.
        setFalse()
    }
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        if sender.isOn {
            setFalse()
        }
        else {
            setTrue()
        }
    }
    

    func handleImagePost() {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = true
        image.accessibilityRespondsToUserInteraction = true
        self.present(image, animated: true)
    }
    
   
    func setTrue() {
        tshirtAdd.isHidden = true
        pantsAdd.isHidden = true
        shoesAdd.isHidden = true
        misc1Add.isHidden = true
        misc2Add.isHidden = true
    }
    
    func setFalse() {
        tshirtAdd.isHidden = false
        pantsAdd.isHidden = false
        shoesAdd.isHidden = false
        misc1Add.isHidden = false
        misc2Add.isHidden = false
    }

    @IBAction func saveButton(_ sender: Any) {
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
                } else if imagePicked == 4 {
                    misc1Image.image = image
                } else if imagePicked == 5 {
                    misc2Image.image = image
                } else {
                    print("something went wrong")
                }
           }else {
            print("something went wrong")
           }
    self.dismiss(animated: true, completion: nil)
    }
}
    
    
