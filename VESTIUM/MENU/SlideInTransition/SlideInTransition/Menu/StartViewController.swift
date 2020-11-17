//
//  StartViewController.swift
//  SlideInTransition
//
//  Created by demi on 10/30/20.
//  Copyright © 2020 Murat Bekgi. All rights reserved.
//

import SwiftUI
import UIKit

class StartViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    let transiton = SlideInTransition()
    var stackView = UIStackView()
    var dateLabel = UILabel()
    var titleLabel = UILabel()
    var logo = UIImageView()
    let outFitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New Outfit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(openNextView), for: .touchUpInside)
        button.backgroundColor = .systemIndigo
        return button
    
    }()
    let collageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create a Collage", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(openNextView), for: .touchUpInside)
        button.backgroundColor = .systemPurple
        return button
    }()
    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        //stackView.backgroundColor = .black
        //addButtonsToStackView()
        stackView.addArrangedSubview(outFitButton)
        stackView.addArrangedSubview(collageButton)
        
        setStackViewConstraints()
       
    }
    func configureDateLabel(){
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE, MMM d, yyyy"
        let currentTime: Date = Date()
        print(dateFormatterPrint.string(from: currentTime));
        dateLabel.text = "\(dateFormatterPrint.string(from: currentTime))"
        dateLabel.numberOfLines = 0
        dateLabel.sizeToFit()
        //dateLabel.backgroundColor = .blue
        dateLabel.textAlignment = .left
        view.addSubview(dateLabel)
        
        
        setLabelConstraints()
    }
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = "Get Started"
        titleLabel.textAlignment = .left
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        
        setTitleConstraints()
        
    }
    func configureLogo() {
        view.addSubview(logo)
        logo.image = UIImage(named: "Image")
        setLogoConstraints()
        
    }
   
    @objc func openNextView() {
        guard let outfitView = storyboard?.instantiateViewController(identifier: "HomeViewController") as?
                HomeViewController else {return }
        self.navigationController?.pushViewController(outfitView, animated: true)
        
        //present(outfitView, animated: true, completion: nil)
    }

    func setStackViewConstraints(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -350).isActive = true
        
        
    }
    func setLabelConstraints(){
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -500).isActive = true
    }
    func setTitleConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -420).isActive = true
    }
    func setLogoConstraints(){
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250).isActive = true
        logo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        logo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        logo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        //any additional setup goes here
        title = "Home"
        view.backgroundColor = .systemBackground
        configureDateLabel()
        configureTitleLabel()
        configureStackView()
        configureLogo()
        
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
   
    
}
extension StartViewController: UIViewControllerTransitioningDelegate{
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}






