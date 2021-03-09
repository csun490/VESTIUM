//
//  User.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/17/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import Foundation

class User {
    var email: String?
    var username: String?
    var profileImageUrl: String?
    var tag: String?
}

// initializing variables
extension User {
    static func transformUser(dict: [String: Any]) -> User {
        let user = User()
        user.email = dict["email"] as? String
        user.username = dict["username"] as? String
        user.profileImageUrl = dict["profileImageUrl"] as? String
        user.tag = dict["tag"] as? String
        // returns user object
        return user
    }
}
