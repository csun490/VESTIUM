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
    let addButton = UIButton()
    
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
                addButton.backgroundColor = UIColor.red
                addButton.layer.cornerRadius = 5.0
                addButton.setTitle("  ADD ITEM  ", for: .normal)
        addButton.addTarget(self, action: #selector(addNewItemDidTap), for: .touchUpInside)
                let spaceItemLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
               // let addItem = UIBarButtonItem(title: "ADD ITEM", style: .plain, target: self, action: #selector(addItemTapped))
                let addItem = UIBarButtonItem(customView: addButton)
                let spaceItemRight = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
                toolbarItems = [spaceItemLeft, addItem, spaceItemRight]
        addItem.tintColor = .red
     
    }
    
    // MARK: - Target / Action
    
    @IBAction func addNewItemDidTap(_ sender: Any) {
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
    }
    
    
    @IBAction func backItemDidTap(_ sender: Any) {
        
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
    
    var selectedImage: UIImage!
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = photoCategories[indexPath.section]
        selectedImage = UIImage(named: category.imageNames[indexPath.item])
        
        performSegue(withIdentifier: Storyboard.showDetailVC, sender: nil)
    }
    
    // MARK: - Delete Items
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        addButton.isEnabled = !editing
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






