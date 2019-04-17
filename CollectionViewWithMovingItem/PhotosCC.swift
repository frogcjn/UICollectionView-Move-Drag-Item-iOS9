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
		if let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) {
			print(cell.contentView.gestureRecognizers!)
		}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this sentence is not neccesary, becuase its default value is true
        //self.installsStandardGestureForInteractiveMovement = true
    }
    
    // MARK: - Data
    
    class Photo {
        var imageData: Data
        
        init(imageData: Data) {
            self.imageData = imageData
        }
    }
    
    lazy var dataItems:[Photo] = {
        var photos = [] as [Photo]
        for index in 0...15 {
            let image = UIImage(named: "\(index)_full")!
			let imageData = image.jpegData(compressionQuality: 1)!
            let photo = Photo(imageData: imageData)
            photos.append(photo)
        }
        return photos
        }()
    
    // MARK: - Read/Modify Item with Index
    
    func configureCell(cell:UICollectionViewCell?, withIndex index: Int){
		configureCell(cell: cell, withDataItem: dataItems[index])
    }
    
    func moveDataItem(sIndex: Int, _ dIndex: Int) {
		let item = dataItems.remove(at: sIndex)
		dataItems.insert(item, at:dIndex)
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

    func indexOf(indexPath: IndexPath) -> Int{
        return indexPath.item
    }
    func indexPathOf(index:Int) -> IndexPath{
        return IndexPath(item: index, section: 0)
    }

    // MARK: UICollectionViewDataSource

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let index = indexOf(indexPath: indexPath)

		configureCell(cell: cell, withIndex: index)
        return cell
    }
    
    //this override is not neccesary, becuase its default return is true
    /*override func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }*/
    
    //must override to get movingItem feature worked
	
	override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		let sIndex = indexOf(indexPath: sourceIndexPath)
        let dIndex = indexOf(indexPath: destinationIndexPath)
        
		moveDataItem(sIndex: sIndex, dIndex)
    }
}

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}


