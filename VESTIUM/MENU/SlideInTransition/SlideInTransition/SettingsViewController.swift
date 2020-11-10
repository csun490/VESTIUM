//
//  SettingsViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/10/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
