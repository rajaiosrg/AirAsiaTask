//
//  SOVirtualKeyPad.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit

class AAVirtualKeyPad: UIView {

    @IBOutlet fileprivate var collectionView : UICollectionView!
    
    fileprivate var reuseVKIdentifier = "SVPinCell"

    fileprivate var flowLayout: UICollectionViewFlowLayout {
        return self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    
}
