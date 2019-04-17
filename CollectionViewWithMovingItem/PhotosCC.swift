//
//  ThingsCC.swift
//  Tota
//
//  Created by 曹剑楠 on 15/5/27.
//  Cootyright (c) 2015年 Cao Jiannan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class PhotosCC: UICollectionViewController {

	lazy var dataItems: [Photo] = {
		var photos = [Photo]()
		for index in 0...15 {
			let image = UIImage(named: "\(index)_full")!
			let imageData = image.jpegData(compressionQuality: 1)!
			let photo = Photo(imageData: imageData)
			photos.append(photo)
		}
		return photos
	}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this sentence is not neccesary, becuase its default value is true
        //self.installsStandardGestureForInteractiveMovement = true
    }

	@IBAction func tapButton(sender: UIBarButtonItem) {
        print(self.installsStandardGestureForInteractiveMovement)
		if let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) {
			print(cell.contentView.gestureRecognizers!)
		}
	}
}

extension PhotosCC {

    // MARK: UICollectionViewDataSource

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCell {
			let item = dataItems[indexPath.row]
			//cell.textLabel?.text = thing.name
			cell.imageView.image = UIImage(data: item.imageData)
			return cell
		}
        return UICollectionViewCell()
    }

    //this override is not neccesary, becuase its default return is true
    /*override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }*/
    
    //must override to get movingItem feature worked
	override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		let sIndex = sourceIndexPath.item
        let dIndex = destinationIndexPath.item
		dataItems.swapAt(sIndex, dIndex)
    }
}
