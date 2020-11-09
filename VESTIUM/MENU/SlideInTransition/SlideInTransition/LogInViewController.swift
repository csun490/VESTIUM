//
//  LogInViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/8/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
}
