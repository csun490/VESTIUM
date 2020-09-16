//
//  ViewController.swift
//  SlideInTransition
//
//  Created by Murat Bekgi on 9/15/20.
//  Copyright © 2020 Murat Bekgi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let transiton = SlideInTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
