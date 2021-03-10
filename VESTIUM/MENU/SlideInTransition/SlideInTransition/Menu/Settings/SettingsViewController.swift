
//
//  SettingsViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/10/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//
/**/


import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SDWebImage
import ProgressHUD
private let reuseIdentifier = "SettingsCell"
class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    // MARK: Properties
    var selectedImage: UIImage?
    var tableView: UITableView!
    var userInfoHeader: UserInfoHeader!
    var profilePictureUrl = String()
    var profileImage = UIImage()
    
    //MARK: Helper funcs
    func configuerProfilePicture(){
        let uid = Auth.auth().currentUser?.uid
        //var userName = String()
        //var email = String()
        let ref = Database.database().reference()
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.hasChild("profile_picture_url"){
                //print("user has profile picture")
                Database.database().reference().child("users").child(uid!).observeSingleEvent(of: DataEventType.value) {  (snapshot: DataSnapshot) in
                    let dict = snapshot.value as? [String: Any]
                    self.profilePictureUrl = dict?["profile_picture_url"] as! String
                    
                    let url = URL(string: self.profilePictureUrl);
                    self.userInfoHeader.profileImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName:"vestium_logo"), options:.continueInBackground, completed: nil)
                    //print("THIS IS PROFILE URL : " + self.profilePictureUrl);
                }
            }else{
                print("User does not have profile picture")
            }
        })


        
        
}
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        userInfoHeader = UserInfoHeader (frame: frame)
        tableView.tableHeaderView = userInfoHeader
        tableView.tableFooterView = UIView()
    }
    func configureUI() {
        configureTableView()
        configuerProfilePicture()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        //navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.title = "Settings"
        
    }
    
    //@IBOutlet weak var username: UILabel!
    //@IBOutlet weak var email: UILabel!
    
   /* var post: Post? {
        didSet {
            setUpUserInfo()
        }
    }
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configuerProfilePicture()
        //setUpUserInfo()
    }
    
    
    func logoutButton() {
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
    func openLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = image
            addProfileImageToFirebase();
            userInfoHeader.profileImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func addProfileImageToFirebase(){
        guard let currentUser = Auth.auth().currentUser?.uid else{
            return;
        }
        let currentUserId = currentUser
        guard let imageSelected = self.selectedImage else{
            print("photo is nil")
            return
        }
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.1)
            else{
                return;
            }
        //let photoIdString = NSUUID().uuidString
        //storageref, need reference to unique uuid to select proper storage location of url
        let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("users").child(currentUserId).child("profile_picture_url")
        storageRef.putData(imageData, metadata: nil){
            (metadata, error) in
            if error != nil{
                print(error!.localizedDescription)
            return
            }
            
        }
        storageRef.downloadURL(completion: { (url: URL?, error: Error?) in
            if let photoUrl = url?.absoluteString {
                self.sendDataToDatabase(photoUrl: photoUrl)
                //onSuccess(photoUrl)
            }
        })
    }
    func sendDataToDatabase(photoUrl: String){
        let ref = Database.database().reference()
        let itemReference = ref.child("users");
        guard let currentUser = Auth.auth().currentUser?.uid else{
            return
        }
        /*
        let thisUsersProfilePictureRef = ref.child("users").child(currentUser).child("profile_picture_url")
        thisUsersProfilePictureRef.setValue(photoUrl) */
        let newItemReference = itemReference.child(currentUser)//.child("profile_picture_url")
        newItemReference.updateChildValues(["profile_picture_url": photoUrl], withCompletionBlock: {(error, ref) in
            if error != nil{
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Success")
        })
       
        
        
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else {return 0}
        
        switch section{
        case .Social: return SocialOptions.allCases.count
        case .Communications: return CommunicationOptions.allCases.count
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .darkGray
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        title.text = SettingsSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        guard let section = SettingsSection(rawValue: indexPath.section) else {return UITableViewCell() }
  
        
        switch section{
        case .Social:
            let social = SocialOptions(rawValue: indexPath.row)
            cell.textLabel?.text = social?.description
        case .Communications:
            let communications = CommunicationOptions(rawValue: indexPath.row)
            cell.textLabel?.text = communications?.description
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingsSection(rawValue: indexPath.section) else {return }
        
        switch section{
        case .Social:
            if (SocialOptions.init(rawValue: indexPath.row)?.description == "Logout"){
                print(SocialOptions(rawValue: indexPath.row)?.description)
                logoutButton()
                tableView.deselectRow(at: indexPath, animated: true)
            }
            else if (SocialOptions.init(rawValue: indexPath.row)?.description == "Change Profile Picture") {
                openLibrary()
                tableView.deselectRow(at: indexPath, animated: true)
            }
        case .Communications:
            print(CommunicationOptions(rawValue: indexPath.row)?.description)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
