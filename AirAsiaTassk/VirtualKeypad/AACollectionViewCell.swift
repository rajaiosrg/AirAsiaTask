//
//  AACollectionViewCell.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit

class AAButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.4, animations: {
                self.backgroundColor = self.isHighlighted ? UIColor.white.withAlphaComponent(0.6) : .clear
            }) { (success : Bool) in
                UIView.animate(withDuration: 0.4, animations: {
                    self.backgroundColor =  .clear
                }) { (success : Bool) in
                }
            }
            
        }
    }
}
class AACollectionViewCell: UICollectionViewCell {
    var  clearColor = UIColor.clear
    
    let numberButton: AAButton = {
        let button = AAButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.white, for: .normal)
        button.tag = 200
        button.backgroundColor = UIColor.clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        numberButton.frame = bounds
        backgroundColor = clearColor
        contentView.backgroundColor = clearColor
        
        numberButton.layer.cornerRadius = 3
        numberButton.layer.borderColor =  UIColor.white.cgColor
        numberButton.layer.borderWidth = 1.0

        addSubview(numberButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
    }
}
