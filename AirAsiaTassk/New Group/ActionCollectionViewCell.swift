//
//  ActionCollectionViewCell.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 16/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit

class ActionCollectionViewCell: UICollectionViewCell {
    var  clearColor = UIColor.clear
    
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tag = 300
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconImageView.frame = bounds
        backgroundColor = clearColor
        contentView.backgroundColor = clearColor
        addSubview(iconImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
    }
}

