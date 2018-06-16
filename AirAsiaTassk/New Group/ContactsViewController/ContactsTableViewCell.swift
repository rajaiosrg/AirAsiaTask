//
//  ContactsTableViewCell.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import Foundation
import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    var contactImageView : UIImageView!
    var name: UILabel!
    var phoneOrEmailLabel: UILabel!
    
    var imageSize : CGFloat = 40
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let labelHeight: CGFloat = 24
        let selfHeight = self.frame.size.height
        let minYOffSet : CGFloat = 5
        let nameLeftSpacing : CGFloat = 10
        
        contactImageView = UIImageView(frame: CGRect(x: 5, y: (selfHeight - imageSize)/2, width: imageSize, height: imageSize))
        contactImageView.contentMode = .scaleAspectFit
        contactImageView.layer.cornerRadius = imageSize/2
        contactImageView.layer.masksToBounds = true
        contentView.addSubview(contactImageView)

        let lableMinX  = contactImageView.frame.maxX + nameLeftSpacing
        
        let labelWidth: CGFloat = self.frame.width - (lableMinX)

        name = UILabel()
        name.frame = CGRect(x: lableMinX, y: minYOffSet, width: labelWidth, height: labelHeight)
        name.textColor = UIColor.black
        name.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(name)
        
        phoneOrEmailLabel = UILabel()
        phoneOrEmailLabel.frame = CGRect(x: lableMinX, y: name.frame.maxY + 1, width: labelWidth, height: labelHeight*0.8)
        phoneOrEmailLabel.textColor = UIColor.black
        phoneOrEmailLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(phoneOrEmailLabel)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
