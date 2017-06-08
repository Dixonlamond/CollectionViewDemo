//
//  DataItemCellCollectionViewCell.swift
//  CollectionViewDemo
//
//  Created by Lamond Dixon on 6/22/16.
//  Copyright © 2016 Lamond Dixon. All rights reserved.
//

import UIKit

class DataItemCell: UICollectionViewCell {
  
  @IBOutlet private weak var dataItemImageView: UIImageView!
  
  var dataItem: DataItem? {
    didSet {
      if let dataItem = dataItem {
        dataItemImageView.image = UIImage(named: dataItem.imageName)
      }
    }
  }
    
}
