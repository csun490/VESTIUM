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
    var stackView = UIStackView()
    var welcomeLabel = UILabel()
    
    @IBOutlet weak var myImage: UIImageView!
    
    let transiton = SlideInTransition()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureTitleLabel()
        //configureStackView()
        // Do any additionl setup after loading the view.
    }
 /*   func addButtonsToStackView(){
        let newOutfitButton = UIButton()
        let libraryButton = UIButton()
        let createCollageButton = UIButton()
        
        
        newOutfitButton.setTitle("Create a new outfit" , for: .normal)
        libraryButton.setTitle("Library", for: .normal)
        createCollageButton.setTitle("Collage", for: .normal)
        newOutfitButton.setTitleColor(UIColor.red, for: .normal)
        libraryButton.setTitleColor(UIColor.red, for: .normal)
        createCollageButton.setTitleColor(UIColor.red, for: .normal)
        stackView.addArrangedSubview(newOutfitButton)
        stackView.addArrangedSubview(libraryButton)
        stackView.addArrangedSubview(createCollageButton)
        
 
       /* let numberOfButtons = 3
        for i in 1...numberOfButtons{
            let button = UIButton()
            button.setTitle("\(i) Create Collage", for: .normal)
            stackView.addArrangedSubview(button)
            
        }
 */
    }
    func configureStackView(){
        view.addSubview(stackView)
        stackView.axis          = .vertical
        stackView.distribution  = .fillEqually
        stackView.spacing       = 10
        addButtonsToStackView()
        setStackViewConstraints()
        
        }
    func configureTitleLabel(){
        view.addSubview(welcomeLabel)
        welcomeLabel.text                       = "Welcome!"
        welcomeLabel.font                       = UIFont.boldSystemFont(ofSize: 36)
        welcomeLabel.textAlignment              = .center
        welcomeLabel.numberOfLines              = 0
        welcomeLabel.adjustsFontSizeToFitWidth  = true
        setWelcomeLabelConstraints()
        
    }
    func setWelcomeLabelConstraints(){
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        welcomeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        
    }
    func setStackViewConstraints(){
        //2:49
        stackView.translatesAutoresizingMaskIntoConstraints                                                           = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive            = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive    = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive     = true
    }
 */
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
    // camera button
    @IBAction func cameraButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
               imagePicker.delegate = self
               imagePicker.sourceType = .camera;
               imagePicker.allowsEditing = true
               present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // photo library button
    @IBAction func libraryButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // accessing photo library
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
