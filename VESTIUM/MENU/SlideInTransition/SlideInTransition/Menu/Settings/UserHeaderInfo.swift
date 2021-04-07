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
import SDWebImage
var profilePicture = UIImage()
class UserInfoHeader: UIView {
    
    var userName = UILabel()
    var email = UILabel()
    func setUpUserInfo() {
        
       /* var myArr = [String]()
        Database.database().reference().child("users").observe(.value){(snapshot) in
            if snapshot.childrenCount > 1{
                myArr.removeAll()
                for data in snapshot.children.allObjects as! [DataSnapshot]{
                    if let d = data.value as? [String: Any]{
                        if Auth.auth.currentuser.uid == d["username"]{
                            userName.text = d[
                        }
                    }
                }
                
            }*/
        let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: DataEventType.value) {  (snapshot: DataSnapshot) in
                let dict = snapshot.value as? [String: Any]
                //let user = User.transformUser(dict: dict!)
                self.userName.text =  dict?["username"] as! String
                self.email.text = dict?["email"] as! String
                //profilePicture = dict?["profile_picture_url"] as! UIImage
                //print(uid)
                
                //print(user.username)
            }
      
    }
    //properties
    var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = profilePicture

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
        
        userName.font = UIFont.systemFont(ofSize: 14)
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.textColor = .white
        email.font = UIFont.systemFont(ofSize: 14)
        email.translatesAutoresizingMaskIntoConstraints = false
        email.textColor = .white

        addSubview(userName)
        userName.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true
        userName.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        
        addSubview(email)
        email.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 10).isActive = true
        email.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
}
