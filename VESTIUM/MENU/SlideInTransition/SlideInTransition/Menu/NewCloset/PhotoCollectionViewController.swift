//
//  PhotosCollectionViewController.swift
//  SlideInTransition
//
//  Created by Mimi  on 4/22/21.
//  Copyright © 2021 CSUN-Vestium. All rights reserved.
//

import UIKit



class PhotoCollectionViewController : UICollectionViewController {
    
    var photoCategories: [PhotoCategory] = PhotosLibrary.fetchPhotos()
    var selectedImage: UIImage!
    var filteredImage: UIImage?
    
    struct Storyboard {
        static let photoCell = "PhotoCell"
        static let sectionHeaderView = "SectionHeaderView"
        static let showDetailVC = "ShowImageDetail"
        
        static let leftAndRightPaddings: CGFloat = 2.0
        static let numberOfItemsPerRow: CGFloat = 3.0
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - change the layout of the collection view
        let collectionViewWidth = collectionView?.frame.width
        let itemWidth = (collectionViewWidth! - Storyboard.leftAndRightPaddings) / Storyboard.numberOfItemsPerRow
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        navigationItem.rightBarButtonItem = editButtonItem
        
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    @IBAction func addItemDidTap(_ sender: Any) {
        handleSelectPhoto()
        
        /*
        // 1 - get a random image
        let firstCategoryImageNames = photoCategories[0].imageNames
        let randomIndex = Int(arc4random()) % firstCategoryImageNames.count
        let randomImageName = firstCategoryImageNames[randomIndex]
      
        // 2 - add the new image into your data model
        photoCategories[0].imageNames.append(randomImageName)
        
        // 3 - update the collection because there's a change in your data source
        // collectionView?.reloadData()
        
        let insertedIndexPath = IndexPath(item: firstCategoryImageNames.count, section: 0)
        collectionView?.insertItems(at: [insertedIndexPath])
    */
    }
    // MARK: - Target / Action
    
    
    func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary;
        pickerController.mediaTypes = ["public.image", "public.movie"]
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photoCategories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCategories[section].imageNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.photoCell, for: indexPath) as! PhotoCell
        let photoCategory = photoCategories[indexPath.section]
        let imageNames = photoCategory.imageNames
        let imageName = imageNames[indexPath.item]
        
        cell.imageName = imageName
        cell.delegate = self
        
        return cell
    }
    
    // Section Header View
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Storyboard.sectionHeaderView, for: indexPath) as! SectionHeaderView
        let category = photoCategories[indexPath.section]
        
        sectionHeaderView.photoCategory = category
        
        return sectionHeaderView
    }
    
    // MARK: - UICollectionViewDelegate
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = photoCategories[indexPath.section]
        selectedImage = UIImage(named: category.imageNames[indexPath.item])
        
        performSegue(withIdentifier: Storyboard.showDetailVC, sender: nil)
    }
    
    // MARK: - Delete Items
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
       // addButton.isEnabled = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? PhotoCell {
                    cell.isEditing = editing
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.showDetailVC {
            let detailVC = segue.destination as! DetailView
            detailVC.image = selectedImage
        }
        
        if segue.identifier ==  "filterSegue" {
            let filterVC = segue.destination as! FilterViewController
            filterVC.selectedImage = self.selectedImage
        }
    }
}

extension PhotoCollectionViewController : PhotoCellDelegate {
    func delete(cell: PhotoCell) {
        if let indexPath = collectionView?.indexPath(for: cell) {
            // 1. delete the photo from our data source
            photoCategories[indexPath.section].imageNames.remove(at: indexPath.item)
            
            // 2. delete the photo cell at that index path from the collection view
            collectionView?.deleteItems(at: [indexPath])
        }
    }
}

extension PhotoCollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("image chosen")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = image
            dismiss(animated: true, completion: { [self] in
                self.performSegue(withIdentifier: "filterSegue", sender: nil)
          
     /*
            let firstCategoryImageNames = photoCategories[0].imageNames
            let randomIndex = Int(arc4random()) % firstCategoryImageNames.count
            let randomImageName = firstCategoryImageNames[randomIndex]
          
            // 2 - add the new image into your data model
            photoCategories[0].imageNames.append(randomImageName)
                
                
            // 3 - update the collection because there's a change in your data source
            // collectionView?.reloadData()
            
            let insertedIndexPath = IndexPath(item: firstCategoryImageNames.count, section: 0)
            collectionView?.insertItems(at: [insertedIndexPath])
      */
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





