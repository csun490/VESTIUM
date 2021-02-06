//
//  TagViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 12/30/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit
import TagListView

class TagViewController: UIViewController, TagListViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tagListView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tagListView.delegate = self
        //tableView.delegate = self
        //tableView.dataSource = self
        
        tagListView.textFont = .systemFont(ofSize: 18)
        tagListView.addTags(["Head", "Top-Inner", "Top-Mid", "Top-Outer", "Bottom", "Feet", "Other"])
        
        
    }
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
    }
    
    
}
/*
extension TagViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }
}

extension TagViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        return cell
    }

}
 */
 
