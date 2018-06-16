//
//  TransactionsViewController.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit

class TransactionsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var reuseIdentifier = "ContactsCell"
    let rowHeight : CGFloat = 50

    let  transactionManager =  TransactionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Transactions"
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        super.setLeftNavigationButton()

        super.setGradientColor(inView: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        transactionManager.refreshTransactionsList()
        tableView.reloadData()
    }
    
    override func handleLeftButonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showTransactionDetailViewController(trans : Transaction) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let transactionsDetailsViewController =  storyboard.instantiateViewController(withIdentifier: "TransactionsDetailsViewController") as! TransactionsDetailsViewController
        transactionsDetailsViewController.transactions = [trans]
        self.navigationController?.pushViewController(transactionsDetailsViewController, animated: true)
    }

}

extension TransactionsViewController : UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactionManager.transactionCount()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = HomeTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        let transaction = self.transactionManager.transactions[indexPath.row]
    
        cell.name.text = transaction.beneficiary
        cell.transactionType.text = transaction.transactionType == TransactionType.Credit.rawValue ? "Cr" : "Dr"
        cell.transferAmount.text = "₹" + String(transaction.transactionAmount)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transaction = self.transactionManager.transactions[indexPath.row]
        showTransactionDetailViewController(trans: transaction)
    }
}

