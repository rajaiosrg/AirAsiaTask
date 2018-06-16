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
    
    fileprivate var reuseVKIdentifier = "AACollectionViewCell"
    fileprivate var view:UIView!
    fileprivate var itemsCount : Int = 10
    fileprivate var interSpace:CGFloat = 5
    fileprivate var flowLayout: UICollectionViewFlowLayout {
        return self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
    }
    public var didTapNumberCallback: ((String)->())?

    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    
    private func loadView() {
        let podBundle = Bundle(for: AAVirtualKeyPad.self)
        let nib = UINib(nibName: "AAVirtualKeyPad", bundle: podBundle)
        view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        collectionView.register(AACollectionViewCell.self, forCellWithReuseIdentifier: reuseVKIdentifier)
        flowLayout.scrollDirection = .horizontal
        collectionView.isScrollEnabled = true
        view.backgroundColor = UIColor.clear
        self.addSubview(view)
        view.frame = bounds
    }
}

extension AAVirtualKeyPad : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseVKIdentifier, for: indexPath)
        
        let numberButton = cell.viewWithTag(200) as! UIButton
        numberButton.addTarget(self, action: #selector(handleNumberAction), for: .touchUpInside)

        numberButton.setTitle(String(indexPath.row), for: .normal)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - (interSpace * CGFloat(max(itemsCount, 1) - 1)))/CGFloat(itemsCount)
        return CGSize(width: width, height: width)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interSpace
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = (collectionView.bounds.width - (interSpace * CGFloat(max(itemsCount, 1) - 1)))/CGFloat(itemsCount)
        let top = (collectionView.bounds.height - width) / 2
        return UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let indexAsString = String(indexPath.item)
        let numberButton = cell?.viewWithTag(200) as! UIButton
        UIView.animate(withDuration: 0.4) {
            numberButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            UIView.animate(withDuration: 0.4, animations: {
                numberButton.backgroundColor = UIColor.clear
            })
        }
        if didTapNumberCallback != nil {
            didTapNumberCallback!(indexAsString)
        }
    }
    
    @objc func handleNumberAction (sender : AAButton) {
        if didTapNumberCallback != nil {
            didTapNumberCallback!(sender.currentTitle!)
        }
    }

    
    public override func layoutSubviews() {
        flowLayout.invalidateLayout()
    }
}
