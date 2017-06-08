//
//  CollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Lamond Dixon on 6/21/16.
//  Copyright © 2016 Lamond Dixon. All rights reserved.
//

import UIKit


class CollectionViewController: UICollectionViewController  {
  var allItems = [[DataItem]]()
  
  
  
  @IBAction func addButtonTapped(sender: UIBarButtonItem) {
    let item = DataItem(title: "New Item", kind: .Animal, imageName: "images-2/default.jpeg")
    let index = allItems[0].count
    allItems[0].append(item)
    let indexPath = NSIndexPath(forItem: index, inSection: 0)
    collectionView?.insertItemsAtIndexPaths([indexPath])
  }
  
  var plantDataItems = [DataItem]()
  var animalDataItems = [DataItem]()
  
  
  
  override func viewDidLoad() {
    for i in 1...12 {
      if i > 9 {
        
        animalDataItems.append(DataItem(title: "Another Title #\(i)", kind: Kind.Animal, imageName: "images-2/anim\(i).jpg"))
        
        plantDataItems.append(DataItem(title: "Title #\(i)", kind: Kind.Plant, imageName: "images-2/img\(i).jpg"))
        
      } else {
        
        animalDataItems.append(DataItem(title: "Another Title #0\(i)", kind: Kind.Animal, imageName: "images-2/anim0\(i).jpg"))
        
        plantDataItems.append(DataItem(title: "Title #0\(i)", kind: Kind.Plant, imageName: "images-2/img0\(i).jpg"))
      }
    }
    
    allItems.append(plantDataItems)
    allItems.append(animalDataItems)
    
    super.viewDidLoad()
    
    let width = CGRectGetWidth(collectionView!.frame) / 3
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: width, height: width)
    
    
    
    
    // add a long press gesture to move the cell around
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Register cell classes
    
    //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
    // Do any additional setup after loading the view.
  }
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using [segue destinationViewController].
   // Pass the selected object to the new view controller.
   }
   */
  
  // MARK: UICollectionViewDataSource
  
  
  // You are moving the cells around!!!
  override func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    var fromSectionItems = allItems[sourceIndexPath.section]
    var toSectionItems = allItems[destinationIndexPath.section]
    let itemToMove = fromSectionItems[sourceIndexPath.row]
    
    if sourceIndexPath.section == destinationIndexPath.section {
      if sourceIndexPath.row != destinationIndexPath.row {
        swap(&toSectionItems[destinationIndexPath.row], &toSectionItems[sourceIndexPath.row])
      }
    } else {
      toSectionItems.insert(itemToMove, atIndex: destinationIndexPath.row)
      fromSectionItems.removeAtIndex(destinationIndexPath.row)
    }
    
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    //_ = allItems[indexPath.item]
  
    let controller = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: .Alert)
    
    
    controller.addAction(UIAlertAction(title: "Delete Picture", style: .Default, handler: {

      
      (action: UIAlertAction!) -> Void in
      
      self.allItems[indexPath.section].removeAtIndex(indexPath.row)
      collectionView.deleteItemsAtIndexPaths([indexPath])
      //collectionView.reloadData()
      
      //self.collectionView!.deleteItemsAtIndexPaths([indexPath])
      //self.allItems.removeAtIndex(indexPath.item)
      
      
    }))
    
    presentViewController(controller, animated: true, completion: nil)
        
    }
  

  
  // don't know if I added this on my own or it was here!!!
  //func beginInteractiveMovementForItem(at indexPath: DataItem) -> Bool {
    //return true
  
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return allItems.count
  }
  
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    //return plantDataItems.count
    return allItems[section].count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! DataItemCell
    //let dataItem = plantDataItems[indexPath.row]
    let dataItem = allItems[indexPath.section][indexPath.row]
    cell.dataItem = dataItem
    
    // Configure the cell
    
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    let sectionHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SectionHeader", forIndexPath: indexPath) as! DataItemHeaderCollectionReusableView
    var title = ""
    if let kind = Kind(rawValue: indexPath.section) {
      title = kind.description()
    }
    //let title  = "Plants"
    sectionHeader.title = title
    
    return sectionHeader
  }
  
  
  
  
  
  // MARK: UICollectionViewDelegate
  
  /*
   // Uncomment this method to specify if the specified item should be highlighted during tracking
   override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment this method to specify if the specified item should be selected
   override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
   override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
   return false
   }
   
   override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
   return false
   }
   
   override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
   
   }
   */
  
 }




