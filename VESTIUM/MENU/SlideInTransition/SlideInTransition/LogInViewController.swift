//
//  LogInViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/8/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // if user is still logged in from previous session, go to home screen
        let user = Auth.auth().currentUser
        if user != nil {
            print("current user:  \(user)")
            self.performSegue(withIdentifier: "loginToHome", sender: nil)
        }
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        self.performSegue(withIdentifier: "createAccount", sender: nil)
    }
    
    // dismiss keyboard when 'return' key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
      }
    
    // dismiss keyboard when user taps on view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // log in via Firebase
    @IBAction func logInButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            if let _eror = error {
                print(_eror.localizedDescription)
                
            } else {
                let userInfo = Auth.auth().currentUser
                let email = userInfo?.email
                print(email)
                //self.performSegue(withIdentifier: "loginToHome", sender: nil )
            
            }
        }
    }
}
