//
//  ContactsManager.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import Foundation
import Contacts

class ContactsManager  {
    
    static let shared  =  ContactsManager()
    var results: [CNContact] = []
    
   private init() {
    
    }
    
  public  func getContacts() {
        self.results.removeAll()
        let fetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactMiddleNameKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor,CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactImageDataKey as CNKeyDescriptor])
        
        fetchRequest.sortOrder = CNContactSortOrder.userDefault
        
        let store = CNContactStore()
        
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { (contact, stop) -> Void in
               // print(contact.phoneNumbers.first?.value ?? "no")
                self.results.append(contact)
            })
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
}
