//
//  ClosetViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 10/27/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit

class ClosetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // to hold the data to be displayed
    var categories = [ImageCategory]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    let headerReuseId = "TableHeaderViewReuseId"
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let headerNib = UINib(nibName: "CustomHeaderView", bundle: nil)
        self.myTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: headerReuseId)
        setupData()
        self.myTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Data initlisers methods
    func setupData() {
        for index in 0..<8 {
            var infoDict = [String:Any]()
            infoDict = dataForIndex(index: index)
            let aCategory = ImageCategory(withInfo: infoDict)
            categories.append(aCategory)
        }
    }
    
    func dataForIndex(index:Int) -> [String:Any] {
        var data = [String:Any]()
        switch index {
        case 0:
            data["cat_name"] = "HEAD"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "HEAD"
            data["cat_items"] = ["beanie","glasses","egg_hat","fleece_hat","brown_hat", "cap"]
        case 1:
            data["cat_name"] = "TOP-INNER"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "TOP-INNER"
            data["cat_items"] = ["black_shirt", "muscle_tank", "green_tank", "white_shirt", "black_tank", "shirt_pack"]
        case 2:
            data["cat_name"] = "TOP-MID"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "TOP-MID"
            data["cat_items"] = ["black_tur","red_fl","green_fl","green_but","tan_sweater", "brown_but"]
        case 3:
            data["cat_name"] = "TOP-OUTER"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "TOP-OUTER"
            data["cat_items"] = ["black_jac", "brown_jac", "green_jac", "wool_coat", "leather_jac", "tan_jac"]
        case 4:
            data["cat_name"] = "BOTTOM"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "BOTTOM"
            data["cat_items"] = ["black_jeans", "dark_jeans", "sweats", "camo_cargo", "light_jeans", "green_cargo"]
        case 5:
            data["cat_name"] = "FEET"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "FEET"
            data["cat_items"] = ["black_shoes", "brown_shoes", "grey_shoes", "red_blue", "white_shoes", "tan_boots"]
        case 6:
            data["cat_name"] = "OTHER"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "OTHER"
            data["cat_items"] = ["belt_bag", "black_bag", "green_back", "grey_back", "sport_set", "tan_bag"]
        default:
            data["cat_name"] = "..."
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "..."
            data["cat_items"] = []
        }
        return data
    }
    
    //MARK:Tableview Delegates and Datasource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell
        if cell == nil {
            cell = CustomTableViewCell.customCell
        }
        let aCategory = self.categories[indexPath.section]
        cell?.updateCellWith(category: aCategory)
        cell?.cellDelegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseId) as? CustomHeaderView
        if view == nil {
            view = CustomHeaderView.customView
        }
        let aCategory = self.categories[section]
        view?.headerLabel.text = aCategory.name
        return view
    }
}

extension ClosetViewController: CustomCollectionCellDelegate {
    func collectionView(collectioncell: CustomCollectionViewCell?, didTappedInTableview TableCell: CustomTableViewCell) {
        if let cell = collectioncell, let selCategory = TableCell.aCategory {
            if let imageName = cell.cellImageName {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let detailController = storyBoard.instantiateViewController(withIdentifier:"DetailViewController") as? DetailViewController
                detailController?.category = selCategory
                detailController?.imageName = imageName
                self.navigationController?.pushViewController(detailController!, animated: true)
                
            }
        }
    }
}

