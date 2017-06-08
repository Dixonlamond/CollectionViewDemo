//
//  DataItemHeaderCollectionReusableView.swift
//  CollectionViewDemo
//
//  Created by Lamond Dixon on 6/22/16.
//  Copyright © 2016 Lamond Dixon. All rights reserved.
//

import UIKit

class DataItemHeaderCollectionReusableView: UICollectionReusableView {
  
  @IBOutlet private weak var titleLabel: UILabel!
  
  var title: String? {
    didSet {
      titleLabel.text = title
    }
  }
        
}
