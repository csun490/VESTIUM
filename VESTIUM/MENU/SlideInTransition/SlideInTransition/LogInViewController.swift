//
//  LogInViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/8/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit
import FirebaseAuth
import ProgressHUD

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var login_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        login_button.isEnabled = false
        login_button.setTitleColor(UIColor.red, for: UIControl.State.normal)
        handleTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // if user is still logged in from previous session, go to home screen
        let user = Auth.auth().currentUser
        if user != nil {
            print("current user:  \(user!)")
            self.performSegue(withIdentifier: "loginToHome", sender: nil)
        }
    }
    
    // selects text fields
    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    // disable login button until user enters text
    @objc func textFieldDidChange() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            login_button.setTitleColor(UIColor.red, for: UIControl.State.normal)
            login_button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            login_button.isEnabled = false
            return
        }
        
        login_button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        login_button.isEnabled = true
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
        view.endEditing(true)
        ProgressHUD.show("Please wait...", interaction: false)
        AuthService.loginFirebase(email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {
            // print success
            print("onSuccess")
            ProgressHUD.showSuccess("Success")
            self.performSegue(withIdentifier: "loginToHome", sender: nil)
        }, onError: { error in
            // print error from firebase
            ProgressHUD.showError(error!)
            print(error!)
        })
        
    }
}
