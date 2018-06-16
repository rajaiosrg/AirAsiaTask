//
//  PaymentsViewController.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit
import Contacts


class PaymentsViewController: BaseViewController {

    public var selectedContact = CNContact()
    
    @IBOutlet weak var availableBalanceLabel: UILabel!
    @IBOutlet weak var payeeLabel : UILabel!
    @IBOutlet weak var payTextField: UITextField!
    @IBOutlet weak var transferReasonTextField: UITextField!
    
    @IBOutlet weak var payButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Pay to \(selectedContact.givenName)"
        let user = CoreDataManger.sharedManager.currentAccountUser

        super.setGradientColor(inView: self.view)
        super.setLeftNavigationButton()
       let placeholderColor = UIColor.white.withAlphaComponent(0.7)
        self.payButton.isEnabled = false
        self.payButton.layer.cornerRadius = payButton.frame.height/2
        self.payButton.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        payTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        payeeLabel.text = "Paying to \(selectedContact.givenName)"
        availableBalanceLabel.text = "Available Balance : ₹\(user.balance)"
        
        configureplaceholderColor(placeholderColor, textField: payTextField)
        configureplaceholderColor(placeholderColor, textField: transferReasonTextField)
    }
    
    override func handleLeftButonAction() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func payButtonAction(_ sender: UIButton) {
        let amount =  payTextField.text ?? ""
        let reason =  transferReasonTextField.text ?? ""
        
        let user = CoreDataManger.sharedManager.currentAccountUser

        // check for sufficient funds
        if Int(amount)! > user.balance {
            showAlert(title: "Balance Error", message: "Insuffiecient funds \n Please check balance once again!!")
            return
        }
    
        let uuid = arc4random_uniform(100000) + 1
        
        
        // create new transaction
        let transaction = CoreDataManger.sharedManager.transactionEntity()
    
        guard let amountInInt = Int(amount) else {
            return 
        }
        transaction.transactionAmount = Int64(amountInInt)
        transaction.transactionId = Int64(uuid)
        transaction.beneficiary = selectedContact.givenName
        transaction.transferer = user.name
        transaction.transactionType = TransactionType.Debit.rawValue
        transaction.transactionDesc = reason
        transaction.beneficiaryNumber = beneficiaryNumber()

        // Save data
        CoreDataManger.sharedManager.saveContext()
        
        // Deduct balance from user
        UserInfoManager().deductAmount(amount : Int(amount)!)
    
        NotificationCenter.default.post(name: .balanceDeductNotifi, object: nil)
        showTransactionDetailViewController(trans: transaction)
    }
    
    func beneficiaryNumber() -> String {
        return selectedContact.phoneNumbers.first?.value.stringValue ?? ""
    }
    
    func configureplaceholderColor(_ color: UIColor, textField : UITextField){
        var placeholderText = ""
        if textField.placeholder != nil{
            placeholderText = textField.placeholder!
        }
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedStringKey.foregroundColor : color])
    }

    func showTransactionDetailViewController(trans : Transaction) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let transactionsDetailsViewController =  storyboard.instantiateViewController(withIdentifier: "TransactionsDetailsViewController") as! TransactionsDetailsViewController
        transactionsDetailsViewController.transactions = [trans]
        self.navigationController?.pushViewController(transactionsDetailsViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @objc fileprivate func textFieldDidChange(_ textField: UITextField) {
        let text =  textField.text ?? ""
        if textField == payTextField {
            payButton.isEnabled = !(text.count == 0)
            payButton.backgroundColor = (text.count == 0) ? UIColor.white.withAlphaComponent(0.7) : UIColor.white
        }
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
