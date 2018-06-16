//
//  HomeTableViewCell.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    var name: UILabel!
    var transactionType: UILabel!
    var transferAmount : UILabel!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let gap : CGFloat = 0
        let labelHeight: CGFloat = 30
        let labelWidth: CGFloat = self.frame.width/3
        let minYOffSet : CGFloat = 5
        
        name = UILabel()
        name.frame = CGRect(x: gap, y: minYOffSet, width: labelWidth, height: labelHeight)
        name.textColor = UIColor.black
        name.textAlignment = .center
        contentView.addSubview(name)
        
        transactionType = UILabel()
        transactionType.frame = CGRect(x: name.frame.maxX, y: minYOffSet, width: labelWidth, height: labelHeight)
        transactionType.textColor = UIColor.black
        transactionType.textAlignment = .center
        contentView.addSubview(transactionType)
        
        transferAmount = UILabel()
        transferAmount.frame = CGRect(x: transactionType.frame.maxX , y: minYOffSet, width: labelWidth, height: labelHeight)
        transferAmount.textColor = UIColor.black
        transferAmount.textAlignment = .center
        contentView.addSubview(transferAmount)
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
