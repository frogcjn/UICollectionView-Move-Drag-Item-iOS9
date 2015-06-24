//
//  ThingsCC.swift
//  Tota
//
//  Created by 曹剑楠 on 15/5/27.
//  Cootyright (c) 2015年 Cao Jiannan. All rights reserved.
//

import UIKit

private typealias CellClass = PhotoCell
private let reuseIdentifier = "PhotoCell"

class PhotosCC: UICollectionViewController {

    // MARK: - Life Cycle
    
    @IBAction func tapButton(sender: UIBarButtonItem) {
        print(self.installsStandardGestureForInteractiveMovement)
        print(collectionView!.cellForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0))?.contentView.gestureRecognizers)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this sentence is not neccesary, becuase its default value is true
        //self.installsStandardGestureForInteractiveMovement = true
    }
    
    // MARK: - Data
    
    class Photo {
        var imageData: NSData
        
        init(imageData: NSData) {
            self.imageData = imageData
        }
    }
    
    lazy var dataItems:[Photo] = {
        var photos = [] as [Photo]
        for index in 0...15 {
            let image = UIImage(named: "\(index)_full")!
            let imageData = UIImageJPEGRepresentation(image, 1.0)!
            let photo = Photo(imageData: imageData)
            photos.append(photo)
        }
        return photos
        }()
    
    // MARK: - Read/Modify Item with Index
    
    func configureCell(cell:UICollectionViewCell?, withIndex index: Int){
        configureCell(cell, withDataItem: dataItems[index])
    }
    
    func moveDataItem(sIndex: Int, _ dIndex: Int) {
        let item = dataItems.removeAtIndex(sIndex)
        dataItems.insert(item, atIndex:dIndex)
    }
    
    // MARK: - Configure Cell
    
    func configureCell(cell:UICollectionViewCell?, withDataItem item: Photo){
        if let cell = cell as? CellClass{
            
            //cell.textLabel?.text = thing.name
            cell.imageView?.image = UIImage(data: item.imageData)
        }
    }
    
}

extension PhotosCC /*(UICollectionViewDataSource)*/ {
    
    // MARK: - Index Transfer

    func indexOf(indexPath:NSIndexPath) -> Int{
        return indexPath.item
    }
    func indexPathOf(index:Int) -> NSIndexPath{
        return NSIndexPath(forItem: index, inSection: 0)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataItems.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        let index = indexOf(indexPath)

        configureCell(cell, withIndex: index)
        return cell
    }
    
    //this override is not neccesary, becuase its default return is true
    /*override func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }*/
    
    //must override to get movingItem feature worked
    override func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let sIndex = indexOf(sourceIndexPath)
        let dIndex = indexOf(destinationIndexPath)
        
        moveDataItem(sIndex, dIndex)
    }
}

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}


