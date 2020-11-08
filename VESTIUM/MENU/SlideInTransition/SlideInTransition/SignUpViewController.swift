//
//  SignUpViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/8/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
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

    // sign up button
    @IBAction func signUpButton(_ sender: Any) {
        // create new user
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
                   if let _eror = error {
                       // user was not created, error
                       print(_eror.localizedDescription )
                   }else{
                       //user registered successfully
                       print(result)
                    
                    // firebase root reference url
                    let ref = Database.database().reference()
                    
                    // create child node in root
                    let userReference = ref.child("users")
                    
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    // new user in root.child
                    let newUserReference = userReference.child(userID)
                    //print(newUserReference)
                    
                    // store username and email to database
                    newUserReference.setValue(["username": self.userNameTextField.text!, "email": self.emailTextField.text!])
                    print("location: \(newUserReference.description())")
                   }
                }
    }
    
}
