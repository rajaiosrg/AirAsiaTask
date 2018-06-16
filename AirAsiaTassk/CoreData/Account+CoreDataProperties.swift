//
//  Account+CoreDataProperties.swift
//  
//
//  Created by Raja Earla on 16/06/18.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var balance: Int16
    @NSManaged public var isSignedIn: Bool
    @NSManaged public var name: String?
    @NSManaged public var pin: Int16
    @NSManaged public var uid: Int16

}
