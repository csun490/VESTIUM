//
//  MenuViewController.swift
//  SlideInTransition
//
//  Created by CSUN-Vestium on 9/15/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case home
    case closet
    case calendar
    case favorites
    case find
    case settings
}

class MenuViewController: UITableViewController {
    
    var didTapMenuType: ((MenuType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        //dismiss(animated: true){ [weak self] in
        print("Dismissing: \(menuType)")
        //self?.didTapMenuType?(menuType)
    }
    
}
