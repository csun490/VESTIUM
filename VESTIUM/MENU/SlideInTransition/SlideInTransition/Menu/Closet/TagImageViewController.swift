//
//  TagImageViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/18/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase
import ProgressHUD

class TagImageViewController: UIViewController, UIImagePickerControllerDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    
    var selectedImage: UIImage?
    var taggedImage: String?
    var num = UInt()
   // let collectionView = TTGTextTagCollectionView()

    
    var selections = [String]()
    
    let tagData = ["Head", "Top-Inner", "Top-Mid", "Top-Outer", "Bottom", "Feet", "Other"]
                                                    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
      /*
        collectionView.alignment = .left
        collectionView.delegate = self
        view.addSubview(collectionView)

        let body = TTGTextTagConfig()
        body.backgroundColor = .white
        body.textColor = .black
       
        collectionView.addTags(["Head", "Top-Inner", "Top-Mid", "Top-Outer", "Bottom", "Feet", "Other"], with: body)
        
        let season = TTGTextTagConfig()
        body.backgroundColor = .white
        season.textColor = .black
        collectionView.addTags(["Spring", "Summer", "Fall", "Winter"], with: season)
        
        */
    }
    

    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func uploadButton(_ sender: Any) {
        print("image uploaded")
        addImageToFirebase()
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    func sendDataToDatabase(photoUrl: String, taggedImage: String, count: String) {
        // create new tag node
        let ref = Database.database().reference()
        let itemReference = ref.child("users")
        
        
        
        guard let currentUser = Auth.auth().currentUser?.uid else {
            return
        }
        let currentUserId = currentUser
        // new item img location
        let newItemID = itemReference.childByAutoId().key
        let newItemReference = itemReference.child(currentUser).child("tags").child(self.taggedImage!)
        newItemReference.updateChildValues([count: photoUrl], withCompletionBlock: {(error, ref) in
            if error != nil{
                ProgressHUD.showError(error!.localizedDescription)
            }
            ProgressHUD.showSuccess("Success!")
        })
        
        
       /* for selection in selections {
            let newTagRef = Api.Tag.REF_TAG.child(selection)
            //newTagRef.updateChildValues([newItemID : true])
        }*/
    
        // push current user and img to firebase storage
        /*newItemReference.setValue(["uid": currentUserId, "photoUrl": photoUrl, "taggedImage": taggedImage], withCompletionBlock: { (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Success")
        })*/
    }
 
    
    func addImageToFirebase() {
        guard let imageSelected = self.selectedImage else {
            print("photo is nil")
            return
        }
        
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.1) else {
            return
        }
        guard let currentUser = Auth.auth().currentUser?.uid else{
            return;
        }
        let currentUserId = currentUser
        
        //don't need this anymore
        
        let photoIdString = NSUUID().uuidString
        /*let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("new item").child(photoIdString)*/
        let ref = Database.database().reference()
        var count = UInt()
        ref.child("users").child(currentUser).child("tags").child(self.taggedImage!).observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
            print("tagged image is ", self.taggedImage!)
            print(snapshot.childrenCount)
            count = snapshot.childrenCount
            self.num = count + 1
            print("COUNT IS, ", self.num)
            

            
        
        print("location is ", self.num)
            let location = String(self.num)
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("users").child(currentUserId).child("tags").child(self.taggedImage!).child(location)
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if error != nil {
                //ProgressHUD.showError(error!.localizedDescription)
                print(error!.localizedDescription)
                return
            }
            storageRef.downloadURL(completion: { (url: URL?, error: Error?) in
                if let photoUrl = url?.absoluteString {
                    self.sendDataToDatabase(photoUrl: photoUrl, taggedImage: self.taggedImage!, count:location)
                    //onSuccess(photoUrl)
                }
            })
        }
    }) // og ref that gets the count, because closure properities THANK YOU SWIFT
}
    
    /*
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 100 , width: view.frame.size.width, height: view.frame.size.height)
    }
    
    // append selection tags in array
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool, tagConfig config: TTGTextTagConfig!) {
        
        selections.append(tagText)
        let lastElement = selections.last
        
        print("\(selections)")
        print(lastElement)
    }
    */

}


extension TagImageViewController: FilterViewControllerDelegate {
    func updatePhoto(image: UIImage) {
        self.selectedImage = image
    }
}

// handles interaction of cells
extension TagImageViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        taggedImage = tagData[indexPath.row]
        print(tagData[indexPath.row])
    }
}

extension TagImageViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tagData[indexPath.row]
        return cell
    }
}

/*
extension Array where Element: Equatable {

  // Remove first collection element that is equal to the given `object`:
  mutating func remove(object: Element) {
      guard let index = firstIndex(of: object) else {return}
      remove(at: index)
  }

}
*/
