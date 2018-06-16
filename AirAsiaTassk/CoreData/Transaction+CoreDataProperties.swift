//
//  Transaction+CoreDataProperties.swift
//  
//
//  Created by Raja Earla on 15/06/18.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var transactionAmount: Int16
    @NSManaged public var transactionId: String?
    @NSManaged public var beneficiary: String?
    @NSManaged public var transactionDesc: String?
    @NSManaged public var transferer: String?

}
