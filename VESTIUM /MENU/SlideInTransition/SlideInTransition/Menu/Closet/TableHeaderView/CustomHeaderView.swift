//
//  CustomHeaderView.swift
//  SlideInTransition
//
//  Created by Mimi  on 10/27/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit
class CustomHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var headerLabel: UILabel!
    class var customView : CustomHeaderView {
        let cell = Bundle.main.loadNibNamed("CustomHeaderView", owner: self, options: nil)?.last
        return cell as! CustomHeaderView
    }
    
   override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.white
    }
}
