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
import TTGTagCollectionView

class TagImageViewController: UIViewController, TTGTextTagCollectionViewDelegate, UIImagePickerControllerDelegate  {
   
    @IBOutlet var tableView: UITableView!
    var selectedImage: UIImage?
    let collectionView = TTGTextTagCollectionView()

    
    var selections = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
       
        
        collectionView.alignment = .left
        collectionView.delegate = self
        view.addSubview(collectionView)

        let body = TTGTextTagConfig()
        body.backgroundColor = .white
        body.textColor = .black
       
        collectionView.addTags(["Head", "Top-Inner", "Top-Mid", "Top-Outer", "Bottom", "Feet", "Other"], with: body)
        
        let season = TTGTextTagConfig()
        //body.backgroundColor = .white
        season.textColor = .black
        collectionView.addTags(["Spring", "Summer", "Fall", "Winter"], with: season)

    }
    

    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func uploadButton(_ sender: Any) {
        print("image uploaded")
        addImageToFirebase()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tagToClosetVC = storyboard.instantiateViewController(identifier: "ClosetViewController")
        self.present(tagToClosetVC, animated: true, completion: nil)
    }
    
    
    func sendDataToDatabase(photoUrl: String) {
        // create new tag node
        let ref = Database.database().reference()
        let itemReference = ref.child("tags")
        
        
        guard let currentUser = Auth.auth().currentUser?.uid else {
            return
        }
        let currentUserId = currentUser
        // new item img location
        let newItemID = itemReference.childByAutoId().key
        let newItemReference = itemReference.child(newItemID!)
        
        for selection in selections {
            let newTagRef = Api.Tag.REF_TAG.child(selection)
            newTagRef.updateChildValues([newItemID : true])
        }
    
        // push current user and img to firebase storage
        newItemReference.setValue(["uid": currentUserId, "photoUrl": photoUrl], withCompletionBlock: { (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Success")
        })
    }
 
    
    func addImageToFirebase() {
        guard let imageSelected = self.selectedImage else {
            print("photo is nil")
            return
        }
        
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.1) else {
            return
        }
        
        let photoIdString = NSUUID().uuidString
        let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("new item").child(photoIdString)
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if error != nil {
                //ProgressHUD.showError(error!.localizedDescription)
                print(error!.localizedDescription)
                return
            }
            storageRef.downloadURL(completion: { (url: URL?, error: Error?) in
                if let photoUrl = url?.absoluteString {
                    self.sendDataToDatabase(photoUrl: photoUrl)
                    //onSuccess(photoUrl)
                }
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 100 , width: view.frame.size.width, height: view.frame.size.height)
    }
    
    // append selection tags in array
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool, tagConfig config: TTGTextTagConfig!) {
        selections.append(tagText)
        print("\(selections)")
    }

}


extension TagImageViewController: FilterViewControllerDelegate {
    func updatePhoto(image: UIImage) {
        self.selectedImage = image
    }
}

// handles interaction of cells
extension TagImageViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
}

extension TagImageViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
}

