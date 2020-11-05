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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        //any additional setup goes here
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
struct StartViewController_Previews: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


