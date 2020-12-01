//
//  FavoriteData.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/30/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import Foundation

class FavData {
    static func dataForIndex(index:Int) -> [String:Any] {
        var data = [String:Any]()
        switch index {
        case 0:
            data["cat_name"] = "SPRING"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Spring"
            data["cat_items"] = ["egg_hat"]
        case 1:
            data["cat_name"] = "SUMMER"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Summer"
            data["cat_items"] = ["green_tank"," "]
        case 2:
            data["cat_name"] = "FALL"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Fall"
            data["cat_items"] = ["red_fl"," "]
        case 3:
            data["cat_name"] = "WINTER"
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "Winter"
            data["cat_items"] = ["wool_coat"," "]
    
        default:
            data["cat_name"] = "..."
            data["cat_id"]   = "\(index)"
            data["cat_description"] = "..."
            data["cat_items"] = []
        }
        return data
    }
}
