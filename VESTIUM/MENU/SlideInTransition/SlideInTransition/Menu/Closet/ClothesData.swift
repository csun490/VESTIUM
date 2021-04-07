//
//  ClothesData.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/11/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SDWebImage
import FirebaseStorage
import FirebaseAuth


class ClothesData {
    static func dataForIndex(index:Int) -> [String:Any] {
       
        var data = [String:Any]()
        switch index {
        case 0:
            data["cat_name"] = "HEAD"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Head"
            data["cat_items"] = ["beanie","glasses","egg_hat","fleece_hat","brown_hat", "cap", "black_white_beanie"]
        case 1:
            data["cat_name"] = "TOP-INNER"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Top-Inner"
            data["cat_items"] = ["black_shirt", "muscle_tank", "green_tank", "white_shirt", "black_tank", "shirt_pack"]
        case 2:
            data["cat_name"] = "TOP-MID"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Top-Mid"
            data["cat_items"] = ["black_tur","red_fl","green_fl","green_but","tan_sweater", "brown_but"]
        case 3:
            data["cat_name"] = "TOP-OUTER"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Top-Outer"
            data["cat_items"] = ["black_jac", "brown_jac", "green_jac", "wool_coat", "leather_jac", "tan_jac"]
        case 4:
            data["cat_name"] = "BOTTOM"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Bottom"
            data["cat_items"] = ["black_jeans", "dark_jeans", "sweats", "camo_cargo", "light_jeans", "green_cargo"]
        case 5:
            data["cat_name"] = "FEET"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Feet"
            data["cat_items"] = ["black_shoes", "brown_shoes", "grey_shoes", "red_blue", "white_shoes", "tan_boots"]
        case 6:
            data["cat_name"] = "OTHER"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Other"
            data["cat_items"] = ["belt_bag", "black_bag", "green_back", "grey_back", "sport_set", "tan_bag"]
        default:
            data["cat_name"] = "..."
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "..."
            data["cat_items"] = []
        }
        return data
    }
}


