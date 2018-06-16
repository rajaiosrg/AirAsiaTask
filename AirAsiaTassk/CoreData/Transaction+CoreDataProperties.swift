//
//  Transaction+CoreDataProperties.swift
//  
//
//  Created by Raja Earla on 15/06/18.
//
//

import Foundation
import CoreData

@objc public enum TransactionType: Int64 {
    case Debit = 0, Credit = 1
}

extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var transactionAmount: Int64
    @NSManaged public var transactionId: Int64
    @NSManaged public var beneficiary: String?
    @NSManaged public var transactionDesc: String?
    @NSManaged public var transferer: String?
    @NSManaged public var transactionType: Int64
    @NSManaged public var beneficiaryNumber: String?

}
