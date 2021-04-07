
//  FavoritesViewController.swift
//  SlideInTransition
//
//  Created by CSUN-Vestium  on 10/6/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import SwiftUI
import UIKit
import Photos
import FirebaseStorage
import Firebase
import FirebaseUI

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
    
    var imagePicked = ""
    var imageNum = 0
    var index = 0
    private let storageRef = Storage.storage().reference()
    
    @IBOutlet weak var tshirtView: UIImageView!
    
    /* Buttonsgit to load items */
    @IBAction func tshirtButton(_ sender: UIButton) {
        imagePicked = "tshirt"
        handleImagePost()
    }
    
    @IBAction func pantsButton(_ sender: UIButton) {
        imagePicked = "pants"
        handleImagePost()
    }
    
    @IBAction func shoeButton(_ sender: UIButton) {
        imagePicked = "shoe"
        handleImagePost()
    }
    
    @IBAction func misc1Button(_ sender: Any) {
        imagePicked = "misc1"
        handleImagePost()
    }
    
    @IBAction func misc2Button(_ sender: Any) {
        imagePicked = "misc2"
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
    
    @IBAction func pullTapped(_ sender: Any) {
        //let ref = storageRef.child("outfits/tshirt")
        //tshirtView.sd_setImage(with: ref)
        
        let picNum = String(index)
            guard let urlString = UserDefaults.standard.value(forKey: ("url" + picNum)) as? String,
                let url = URL(string: urlString) else {
                return
            }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.tshirtView.image = image
            }
        })
        task.resume()
        index = index + 1
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
            if imagePicked == "tshirt"{
                shirtImage.image = image
            } else if imagePicked == "pants" {
                pantsImage.image = image
               
            } else if imagePicked == "shoe" {
                shoeImage.image = image
              
            } else if imagePicked == "misc1" {
                misc1Image.image = image
               
            } else if imagePicked == "misc2" {
                misc2Image.image = image
                
            } else {
                print("something went wrong")
            }
        }else {
            print("cannot check image")
        }
        
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL { //  item will be pushed to firebase
            print(url)
            uploadtoCloud(fileURL: url, imageDescription: imagePicked)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /* this function uploads images to firebase */
    func uploadtoCloud(fileURL : URL, imageDescription : String){
        
        // directory where the items will be stored on cloud
        storageRef.child("outfits/" + imageDescription).putFile(from: fileURL, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                print("Cannot create upload task")
                return
            }
            print("Photo uploaded to cloud")
            /* uploading the item storing url and saving to userdefaults */
            self.storageRef.child("outfits/" + imageDescription).downloadURL(completion: { url, error in
                guard let url = url, error == nil else{
                    return
                }
                let urlString = url.absoluteString
                let picNumber = String(self.imageNum)
                print("downloading URL: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: ("url" + picNumber))
                self.imageNum+=1
            })
        }
        
    }
    
}
