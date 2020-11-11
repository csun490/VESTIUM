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
    
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var signup_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        signup_button.isEnabled = false
        errorMessage.isHidden = true
        signup_button.setTitleColor(UIColor.red, for: UIControl.State.normal)
        handleTextField()
        
    }
    
    
    func handleTextField() {
        userNameTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    // disables sign up button if text fields are empty
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let username = userNameTextField.text, !username.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
                signup_button.setTitleColor(UIColor.red, for: UIControl.State.normal)
                signup_button.isEnabled = false
                return
        }
        
        signup_button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        signup_button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        signup_button.isEnabled = true
        
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
    

    
    // go to login view
    @IBAction func goToLoginView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
        // creates new user
    @IBAction func signUpButton(_ sender: Any) {
        // create new user
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
                   if let _eror = error {
                       // user was not created, error
                       print(_eror.localizedDescription)
                   } else {
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
                    self.performSegue(withIdentifier: "signUpToHome", sender: nil )
                    
                   }
        }
    }
    
}
