//
//  DetailsViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 10/22/20.
//  Copyright © 2020 Murat Bekgi. All rights reserved.
//

import Foundation
import UIKit


class DetailsViewController: UIViewController {
    
    var backgroundColor: UIColor!
    var backgroundColorName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        self.navigationItem.title = backgroundColorName
    }
}
