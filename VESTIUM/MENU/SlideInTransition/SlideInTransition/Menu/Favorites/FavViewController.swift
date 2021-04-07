//
//  FavViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 11/30/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase
import ProgressHUD
import SDWebImage

class FavViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!

    
    // to hold the data to be displayed
    var categories = [ImageCategory]()
    var selectedImage: UIImage?
    var posts = [Post]()
    
    
    let headerReuseId = "TableHeaderViewReuseId"
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favorites"
        // Do any additional setup after loading the view, typically from a nib.
        let headerNib = UINib(nibName: "CustomHeaderView", bundle: nil)
        self.myTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: headerReuseId)
        setupData()
        self.myTableView.reloadData()
        //loadPosts()
        
    }
    
  
    @IBAction func addLookButton(_ sender: Any) {
        print("add look tapped")
        self.performSegue(withIdentifier: "favoriteSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "favoriteSegue" {
            let favoriteVC = segue.destination as! FavoritesViewController
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Data initializers methods
    func setupData() {
        for index in 0..<7 {
            var infoDict = [String:Any]()
            infoDict = FavData.dataForIndex(index: index)
            let aCategory = ImageCategory(withInfo: infoDict)
            categories.append(aCategory)
        }
    }
    
    func sendDataToDatabase(photoUrl: String) {
        let ref = Database.database().reference()
        let itemReference = ref.child("new items")
        guard let currentUser = Auth.auth().currentUser?.uid else {
            return
        }
        let currentUserId = currentUser
        // new item img location
        let newItemID = itemReference.childByAutoId().key
        let newItemReference = itemReference.child(newItemID!)
        // push img to firebase storage
        newItemReference.setValue(["uid": currentUserId, "photoUrl": photoUrl], withCompletionBlock: { (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Success")
        })
    }
    
    func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary;
        pickerController.mediaTypes = ["public.image", "public.movie"]
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
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
    
    
    //retrieves "new item" images from firebase
    func loadPosts() {
        Database.database().reference().child("new items").observe(.childAdded) { (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let newPost = Post.transformPost(dict: dict)
                self.posts.append(newPost)
                print(self.posts)
                self.myTableView.reloadData()
            }
        }
    }
    
    
    //MARK:Tableview Delegates and Datasource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell
        if cell == nil {
            cell = CustomTableViewCell.customCell
        }
        /*
        let post = posts[indexPath.row]
        if let photoUrlString = post.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            cell!.myCollectionView.sd_setImage(with: photoUrl)
        }
        */
        
        let aCategory = self.categories[indexPath.section]
        cell?.updateCellWith(category: aCategory)
        cell?.cellDelegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseId) as? CustomHeaderView
        if view == nil {
            view = CustomHeaderView.customView
        }
        let aCategory = self.categories[section]
        view?.headerLabel.text = aCategory.name
        return view
    }
}

extension FavViewController: CustomCollectionCellDelegate {
    func collectionView(collectioncell: CustomCollectionViewCell?, didTappedInTableview TableCell: CustomTableViewCell) {
        if let cell = collectioncell, let selCategory = TableCell.aCategory {
            if let imageName = cell.cellImageName {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let detailController = storyBoard.instantiateViewController(withIdentifier:"DetailViewController") as? DetailViewController
                detailController?.category = selCategory
                detailController?.imageName = imageName
                self.navigationController?.pushViewController(detailController!, animated: true)
                
            }
        }
    }
}

extension FavViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("image chosen")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = image
            dismiss(animated: true, completion: {
               // self.performSegue(withIdentifier: "filterSegue", sender: nil)
            })
        }
        
        if let imageEdited = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = imageEdited
        }
        //dismiss(animated: true, completion: nil)
        
        //send image to firebase immediately after picking
        //addImageToFirebase()
    }
}

