//
//  ContactsViewController.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import UIKit
import Contacts

class ContactsViewController: BaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var reuseIdentifier = "ContactsCell"
    let rowHeight : CGFloat = 50
    
    var contactsArray : [CNContact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        self.contactsArray = ContactsManager.shared.results
        
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        super.setLeftNavigationButton()
    }
    
   override func handleLeftButonAction() {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}


extension ContactsViewController : UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactsArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ContactsTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        let contact = self.contactsArray[indexPath.row]
        
        cell.name?.text = contact.givenName
        cell.phoneOrEmailLabel?.text = contact.phoneNumbers.first?.value.stringValue ?? ""
        cell.contactImageView?.image =   contact.imageData != nil ? UIImage(data: contact.imageData!) : UIImage(named: "ic_user")
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = self.contactsArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let paymentsViewController =  storyboard.instantiateViewController(withIdentifier: "PaymentsViewController") as! PaymentsViewController
        paymentsViewController.selectedContact = contact
        self.navigationController?.pushViewController(paymentsViewController, animated: true)

    }
    
}
