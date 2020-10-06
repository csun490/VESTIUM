//
//  ClosestViewController.swift
//  SlideInTransition
//
//  Created by CSUN-Vestium on 9/24/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit
import FirebaseStorage

class ClosetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    @IBOutlet var imageView: UIImageView!
  //  @IBOutlet var collectionView: UICollectionView!
    
    private let storage = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Closet"
        
        // image url string
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String, let url = URL(string: urlString) else {
            return
        }
        // download data from url
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // image data downloaded and convert to image
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        })
        
        task.resume()
    }
        /*
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.itemSize   = CGSize(width: 100, height: 100)
        
        // registers cell being used for image
        collectionView.register(ClosetCollectionViewCell.nib(), forCellWithReuseIdentifier: ClosetCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        */
     
  
    
    //add item button has access to photo library
    @IBAction func addItemButton() {
        //photo library picker
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // when user finishes picking photo, grabs photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        //get data of image
        guard let imageData = image.pngData() else {
            return
        }
        
        // reference of url = storage.child("images/file.png")
        storage.child("images/file.png").putData(imageData, metadata: nil, completion: {_, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
         
            // upload image data
            // get download URL
            // save download URL to userDefaults
            self.storage.child("images/file.png").downloadURL(completion: {url, error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
               
                //updates image from url to screen on main thread
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            })
            
        })

        
    }

    // cancel button in photo library
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

/*
// picks up interactions with cells
extension ClosetViewController: UICollectionViewDelegate{
    // when cells are tapped in collection view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("cell tapped")
    }
}

extension ClosetViewController: UICollectionViewDataSource{
    // how many cells we want in a given section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    // returns cell of a given item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClosetCollectionViewCell.identifier, for: indexPath) as! ClosetCollectionViewCell
        
        cell.configure(with: UIImage(named: "sunglasses")!)
        
        return cell
    }
}


// margin and padding of each cell
extension ClosetViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
 */
 
