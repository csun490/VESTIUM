//
//  UserInfoHeader.swift
//  SlideInTransition
//
//  Created by demi on 11/19/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UserInfoHeader: UIView {
    
    var username = UILabel()
    var email = UILabel()
    
   /* var post: Post? {
        didSet{
            setUpUserInfo()
        }
    }*/
    func setUpUserInfo() {
        username.text = "erick"
        email.text = "nobody@gmail.com"
        /*
        let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: DataEventType.value) {  (snapshot: DataSnapshot) in
                let dict = snapshot.value as? [String: Any]
                let user = User.transformUser(dict: dict!)
                self.username.text =  user.username
                self.email.text = user.email
                print(uid)
                print(user.username)
            } */
    }
    //properties
    var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "vestium_logo")
        return iv
    }()
  /*  let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = username
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = email
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()*/
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        let profileImageDimension: CGFloat = 60
        setUpUserInfo()
        addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.layer.cornerRadius = profileImageDimension / 2
        
        username.font = UIFont.systemFont(ofSize: 14)
        username.translatesAutoresizingMaskIntoConstraints = false
        username.textColor = .white
        email.font = UIFont.systemFont(ofSize: 14)
        email.translatesAutoresizingMaskIntoConstraints = false
        email.textColor = .white

        addSubview(username)
        username.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true
        username.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        
        addSubview(email)
        email.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 10).isActive = true
        email.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
}

