//
//  AccountInfoHeader.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit

class AccountInfoHeader: UITableViewHeaderFooterView {

    var accountNumber: UILabel!
    var balance: UILabel!
    var payButton : UIButton!
    
    fileprivate var PayButtonWidth : CGFloat = 140
    
    var onPayButtonActionClosure: (() -> Void)?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    
        accountNumber = UILabel()
        accountNumber.textColor = UIColor.black
        accountNumber.textAlignment = .center
        accountNumber.font = UIFont.systemFont(ofSize: 19)
        contentView.addSubview(accountNumber)
        
        balance = UILabel()
        balance.textColor = UIColor.black
        balance.textAlignment = .center
        balance.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(balance)
        
        
        payButton = UIButton(type: .custom)
        payButton.setTitle("Transfer Funds", for: .normal)
        payButton.tintColor = UIColor.black
        payButton.setTitleColor(UIColor.black, for: .normal)
        payButton.layer.cornerRadius = 5
        payButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        payButton.layer.borderColor = UIColor.black.cgColor
        payButton.layer.borderWidth = 1.0
        payButton.addTarget(self, action: #selector(handlePayButtonAction), for: .touchUpInside)
        contentView.addSubview(payButton)
        contentView.backgroundColor = UIColor.clear
    }
    
   public func configureFrames() {
        let minYOffset : CGFloat = 25
        let selfWidth: CGFloat = self.frame.width
        let lableHeight: CGFloat = 30
        let yMinGap : CGFloat = 5

        accountNumber.frame = CGRect(x: 0 , y: minYOffset, width: selfWidth, height: lableHeight)
        balance.frame = CGRect(x: accountNumber.frame.minX, y: accountNumber.frame.maxY + yMinGap, width: selfWidth, height: lableHeight)
        payButton.frame = CGRect(x: (selfWidth - PayButtonWidth)/2, y: balance.frame.maxY + 20, width: PayButtonWidth, height: 36)
    }
    
    @objc func handlePayButtonAction () {
        if let closureCompletion = onPayButtonActionClosure {
            closureCompletion()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
