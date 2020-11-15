//
//  Post.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/13/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import Foundation

class Post {
    var photoUrl: String?

}

extension Post {
    // returns an instance of Post
    static func transformPost(dict: [String: Any]) -> Post {
        let post = Post()
        post.photoUrl = dict["photoUrl"] as? String
        return post
    }
}

