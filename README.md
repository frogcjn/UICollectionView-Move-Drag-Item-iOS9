CollectionViewWithMovingItem
====================

This sample code shows how to use official API to move/drag item in collection, which is new feature in iOS9.

Instruction on Dragging:

* long press item to start moving
* release touch to put item down


Instruction on Development:

In order to let the movingItem feature work, you should do 2 things:

* Using UICollectionViewController

  It will automatically install UILongPressGestureRecognizer to your cell.contentView.
  In default, UICollectionViewController.installsStandardGestureForInteractiveMovement = true 

* Implement/Override collectionView(_:moveItemAtIndexPath:toIndexPath)

  This function is required to implement, in order to get dragItem feature


![ScreenShot](_mov.gif)
