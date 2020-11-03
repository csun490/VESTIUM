
    //  FavoritesViewController.swift
    //  SlideInTransition
    //
    //  Created by CSUN-Vestium  on 10/6/20.
    //  Copyright © 2020 CSUN-Vestium. All rights reserved.
    //

    import SwiftUI
    import UIKit

    class FavoritesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
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

}
