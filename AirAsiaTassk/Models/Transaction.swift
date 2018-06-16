//
//  Transaction.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import Foundation
import CoreData

public enum TransactionType: Int , Codable {
    case Debit, Credit
}

class Transaction : NSManagedObject {
    
    @NSManaged var menuText: String
    @NSManaged var createdAt: NSDate
}
