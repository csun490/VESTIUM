//
//  TagViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/29/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit


class TagViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
   
    let selections = [
        "Head",
        "Top-Inner",
        "Top-Mid",
        "Top-Outer",
        "Bottom",
        "Feet",
        "Other"
    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
}



extension TagViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
}

extension TagViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = selections[indexPath.row]
        return cell
    }
}
    
  
