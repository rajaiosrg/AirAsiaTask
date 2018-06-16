//
//  HomeViewController.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var reuseIdentifier = "HomeTableViewCell"
    fileprivate let headerIdentifier = "HomeTableViewHeader"

    let headerViewHeight: CGFloat = 170
    let homeScreenRowHeight : CGFloat = 50
    let  transactionManager =  TransactionManager()
    public var isFromLoginScreen : Bool = false
    let tableViewheader = AccountInfoHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Account Info"
        tableView.register(AccountInfoHeader.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableViewheader.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: headerViewHeight)
        tableViewheader.configureFrames()
        tableView.tableHeaderView = tableViewheader
        updateTableViewheader()

        tableViewheader.onPayButtonActionClosure = { () -> Void in
            self.showContactViewController()
        }
        tableView.tableFooterView = UIView()
        ContactsManager.shared.getContacts()
        addObservers()
        self.navigationController?.navigationBar.isHidden = false
        
    }
        
    func updateTableViewheader() {
        let user = CoreDataManger.sharedManager.currentAccountUser
        let balance = String(user.balance)

        tableViewheader.accountNumber.text =  "Account No : " + String(user.uid)
        tableViewheader.balance.text = "Balance : ₹\(balance)"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFromLoginScreen {
            self.navigationController?.navigationBar.backItem?.hidesBackButton = true
            // remove left buttons (in case you added some)
            self.navigationItem.leftBarButtonItems = []
            // hide the default back buttons
            self.navigationItem.hidesBackButton = true
        }
    }
    
    
    func addObservers()  {
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeInBalance(notfication:)), name: .balanceDeductNotifi, object: nil)
    }
    

    
    func showContactViewController () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contactsViewController =  storyboard.instantiateViewController(withIdentifier: "ContactsViewController")
        self.navigationController?.pushViewController(contactsViewController, animated: true)
    }    
    
    @objc func didChangeInBalance(notfication: NSNotification) {
        transactionManager.refreshTransactionsList()
        updateTableViewheader()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension Notification.Name {
    static let balanceDeductNotifi = Notification.Name("didChangeBalanceNotif")
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return homeScreenRowHeight
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
}
