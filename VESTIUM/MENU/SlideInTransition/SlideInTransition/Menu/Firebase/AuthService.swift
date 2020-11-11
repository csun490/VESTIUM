//
//  AuthService.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/10/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class AuthService {
    
    // login
    static func loginFirebase(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void ) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                onError(error!.localizedDescription)
                // print(_eror.localizedDescription)
                return  
            } else {
                let userInfo = Auth.auth().currentUser
                let email = userInfo?.email
                print("email: \(email!)")
                onSuccess()
            }
        }
    }
    
    // sign up
    static func signupFirebase(username: String, email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void ) {
        // create new user
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                // user was not created, error
                onError(error!.localizedDescription)
                print(error!.localizedDescription)
                return
            } else {
                //user registered successfully
                let uid = Auth.auth().currentUser?.uid
                //print(result)
                self.setUserInformation(username: username, email: email, uid: uid!, onSuccess: onSuccess)
            }
        }
    }
    
    static func setUserInformation(username: String, email: String, uid: String, onSuccess: @escaping () -> Void) {
        // firebase root reference url
        let ref = Database.database().reference()
        // create child node in root
        let userReference = ref.child("users")
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        // new user in root.child
        let newUserReference = userReference.child(userID)
        //print(newUserReference)
        
        // store username and email to database
        newUserReference.setValue(["username": username, "email": email])
        print("location: \(newUserReference.description())")
        onSuccess()
    }
    
}
