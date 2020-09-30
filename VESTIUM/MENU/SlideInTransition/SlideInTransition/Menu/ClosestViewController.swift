//
//  ClosestViewController.swift
//  SlideInTransition
//
//  Created by CSUN-Vestium on 9/24/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit
import Firebase

class ClosetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    @IBOutlet var imageView: UIImageView!
    //source of downloaded image
    @IBOutlet var label: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Closet"
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.itemSize = CGSize(width: 100, height: 100)
        
        // registers cell being used for image
        collectionView.register(ClosetCollectionViewCell.nib(), forCellWithReuseIdentifier: ClosetCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
     
    }
    
    //add item button has access to photo library
    @IBAction func addItemButton() {
        //photo library picker
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
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
        // upload image data
        // get download URL
        // save download URL to userDefaults
    }

    // cancel button in photo library
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

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
 
