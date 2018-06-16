//
//  UserInfoManager.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import Foundation
import CoreData

public class UserInfoManager {
    
    var coreDataManager = CoreDataManger.sharedManager
    
    func markUserAsLoggedIn(userId : Int64)  {
        let user  = coreDataManager.currentUser(userId: userId)
        user.isSignedIn = true
        coreDataManager.saveContext()
    }
    
    func deductAmount(amount : Int)  {
        let accountManagedObjectID = coreDataManager.currentAccountUser.objectID
        let user  = coreDataManager.fetchAccountByManagedObjecID(managedObjectId: accountManagedObjectID) as Account
        var balance = user.balance
        if balance > amount {
            balance = balance - Int64(amount)
        }
        user.balance = balance
        coreDataManager.saveContext()
    }
}
