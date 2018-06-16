//
//  TransactionsDetailsViewController.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit
import Contacts

class TransactionsDetailsViewController: BaseViewController {

    var transactions = [Transaction]()
    var numberOfRows : Int = 0
    
    @IBOutlet weak var transactionDetailsLabel: UILabel!
    @IBOutlet weak var beneficiaryNumberLabel: UILabel!
    
    @IBOutlet weak var beneficiaryNameLabel: UILabel!
    @IBOutlet weak var transferedAmountLabel: UILabel!
    @IBOutlet weak var transactionIDLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Transaction Details"
        
        super.setLeftNavigationButton()
        super.setGradientColor(inView: self.view)
        configureTransactionLabelStyles()
        populateWithTransaction()
    }
    
    func configureTransactionLabelStyles()  {
        let whiteColor = UIColor.white
        transactionDetailsLabel.textColor = whiteColor
        beneficiaryNumberLabel.textColor = whiteColor
        beneficiaryNameLabel.textColor = whiteColor
        transferedAmountLabel.textColor = whiteColor
        transactionIDLabel.textColor = whiteColor
        shareButton.backgroundColor = whiteColor
        shareButton.layer.cornerRadius = shareButton.frame.size.height/2
        shareButton.layer.masksToBounds = true
    }
    
    func populateWithTransaction() {
        let transaction = transactions.first
        let transeferedAmount = transaction?.transactionAmount
        let transactionId = transaction?.transactionId
        let beneficiaryNumber = transaction?.beneficiaryNumber
        beneficiaryNumberLabel.text =   "Beneficiary Number : \(beneficiaryNumber ?? "")"
        beneficiaryNameLabel.text =  "Beneficiary Name : \(transaction?.beneficiary ?? "")"
        transferedAmountLabel.text =  "Transfered Amount : \(transeferedAmount!)"
        transactionIDLabel.text =  "Transaction ID : \(transactionId!)"
    }

    func transactionAmount() -> Int64 {
        let transaction = transactions.first
        return (transaction?.transactionAmount)!
    }
    
    @IBAction func handleShareButtonAction(_ sender: UIButton) {
        let transaction = transactions.first

        let msg = "Hi \(transaction?.beneficiary ?? "")," + " I have trasfered Party Share of last month ₹ \(transactionAmount())"
        let urlWhats = "whatsapp://send?text=\(msg)"
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.open(whatsappURL as URL, options: [:]) { (Bool) in
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    }
                } else {
                    print("please install WhatsApp")
                }
            }
    }
    override func handleLeftButonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
