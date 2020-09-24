//
//  ViewController.swift
//  SlideInTransition
//
//  Created by CSUN-Vestium on 9/15/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import SwiftUI
import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myImage: UIImageView!
    
    let transiton = SlideInTransition()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additionl setup after loading the view.
    }
   
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
       guard let menuViewController = storyboard?.instantiateViewController(withIdentifier:"MenuViewController") as?
        MenuViewController else {return}
        menuViewController.didTapMenuType = { menuType in
                   print(menuType)
               }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    
    @IBAction func cameraButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
               imagePicker.delegate = self
               imagePicker.sourceType = .camera;
               imagePicker.allowsEditing = true
               present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func libraryButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            myImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
    

}
