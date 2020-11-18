//
//  SettingsViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/10/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserInfo()
    }
    
    func setUpUserInfo() {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: DataEventType.value) {  (snapshot: DataSnapshot) in
            let dict = snapshot.value as? [String: Any]
            let user = User.transformUser(dict: dict!)
            self.username.text =  user.username
            self.email.text = user.email
            //print(uid)
            //print(user.username)
        }
    }
    
    // log out button
    @IBAction func logoutButton(_ sender: Any) {
        print(Auth.auth().currentUser)
        do {
            try Auth.auth().signOut()
        } catch { print("Already logged out")
            print(Auth.auth().currentUser)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginInVC = storyboard.instantiateViewController(identifier: "LogInViewController")
        self.present(loginInVC, animated: true, completion: nil)
    }
    
}
