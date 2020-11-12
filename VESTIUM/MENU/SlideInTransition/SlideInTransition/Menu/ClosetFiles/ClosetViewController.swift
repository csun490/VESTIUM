//
//  ClosetViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 10/27/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase
import ProgressHUD


class ClosetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addNewItem_button: UIButton!
    
    // to hold the data to be displayed
    var categories = [ImageCategory]()
    var selectedImage: UIImage?
    
    @IBOutlet weak var myTableView: UITableView!
    
    let headerReuseId = "TableHeaderViewReuseId"
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let headerNib = UINib(nibName: "CustomHeaderView", bundle: nil)
        self.myTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: headerReuseId)
        setupData()
        self.myTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Data initializers methods
    func setupData() {
        for index in 0..<8 {
            var infoDict = [String:Any]()
            infoDict = ClothesData.dataForIndex(index: index)
            let aCategory = ImageCategory(withInfo: infoDict)
            categories.append(aCategory)
        }
    }
    
    func sendDataToDatabase(photoUrl: String) {
        let ref = Database.database().reference()
        let itemReference = ref.child("new items")
        // new item img location
        let newItemID = itemReference.childByAutoId().key
        let newItemReference = itemReference.child(newItemID!)
        // push img to firebase storage
        newItemReference.setValue(["photoUrl": photoUrl])
    }
    
    // access to photolibrary to add new item in closet
    @IBAction func addNewItem(_ sender: Any) {
        handleSelectPhoto()
        
        ProgressHUD.show("Waiting...", interaction: false)
        if let newItemImg = self.selectedImage, let imageData = newItemImg.jpegData(compressionQuality: 0.1) {
            // generate unique photo id
            let photoIdString = NSUUID().uuidString
            // create storage node
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("New Item").child(photoIdString)
            // store image to Firebase Storage
            storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if error != nil {
                    return
                }
                storageRef.downloadURL(completion: { (url: URL?, error: Error?) in
                    if let photoUrl = url?.absoluteString {
                       // onSuccess(photoUrl)
                    }
                })
            }
            
        } else {
            ProgressHUD.showError("Profile Image can't be empty")
        }
    }
    
    func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary;
        pickerController.mediaTypes = ["public.image", "public.movie"]
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    
    //MARK:Tableview Delegates and Datasource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell
        if cell == nil {
            cell = CustomTableViewCell.customCell
        }
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

extension ClosetViewController: CustomCollectionCellDelegate {
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

extension ClosetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("image chosen")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = image
            
        }
        dismiss(animated: true, completion: nil)
    }
}


