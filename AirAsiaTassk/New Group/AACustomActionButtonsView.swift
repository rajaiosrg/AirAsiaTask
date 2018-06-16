//
//  AACustomActionButtonsView.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 16/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit

@objc public enum ActionType: Int {
    case Home = 0, Transactions = 1, Logout = 2
}

class AACustomActionButtonsView: UIView  {

    var collectionview: UICollectionView!
    var dataArray = [ActionType]()
    
    fileprivate var reuseIdentifier = "ActionCollectionViewCell"
    fileprivate var interSpace:CGFloat = 5

    
    

//    fileprivate var edgeMenu: DPEdgeMenu?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dataArray.append(.Home)
        dataArray.append(.Transactions)
        dataArray.append(.Logout)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.scrollDirection = .horizontal
        
        collectionview = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(ActionCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.clear
        self.addSubview(collectionview)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @objc func homeButtonAction(_ sender: UIButton?) {
        
    }
    
    @objc func transactionAction(_ sender: UIButton?) {
        
    }
    
    @objc func logoutAction(_ sender: UIButton?) {
        
    }
    
    @objc func doActionD(_ sender: UIButton?) {
        
    }
}

extension AACustomActionButtonsView : UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        //The tag of the last cell of the pinView is (100 + (pinLength - indexPath.row))
        let imageView = cell.viewWithTag(300) as! UIImageView
        
        let actionType = dataArray[indexPath.row]
        let  imageName : String
        
        switch actionType {
        case .Home:
            imageName = "home"
            break
        case .Transactions:
            imageName = "transaction"
            break
        case .Logout:
            imageName = "logout"
            break
            
        default: break
            
        }
        imageView.image = UIImage(named: imageName)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - (interSpace * CGFloat(max(dataArray.count, 1) - 1)))/CGFloat(dataArray.count)
        return CGSize(width: width, height: width)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interSpace
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = (collectionView.bounds.width - (interSpace * CGFloat(max(dataArray.count, 1) - 1)))/CGFloat(dataArray.count)
        let top = (collectionView.bounds.height - width) / 2
        return UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var indexAsString = String(indexPath.item)
        print("\(indexAsString)")
    }
    
}

