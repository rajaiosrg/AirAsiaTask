//
//  CoreDataManager.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataManger {
    
    static let sharedManager = CoreDataManger()
    var currentAccountUser = Account()
    
    func insertOrUpdateUserInMoc(with userId : Int64 , moc : NSManagedObjectContext) -> Account {
        
        let userFetch = NSFetchRequest<NSManagedObject>(entityName: "Account")
        userFetch.predicate = NSPredicate(format: "uid == %lld", userId)
        var account = Account()
        do {
            let fetchedUsers = try moc.fetch(userFetch as! NSFetchRequest<NSFetchRequestResult>)
            
            if fetchedUsers.count == 0 {
                let accountEntity = NSEntityDescription.entity(forEntityName: "Account", in: moc)!
                account = NSManagedObject(entity: accountEntity, insertInto: moc) as! Account
            } else {
                account = fetchedUsers.first as! Account
            }
            CoreDataStack.sharedStack.saveContext()
            return account
        } catch {
            fatalError("Failed to fetch Account: \(error)")
        }
    }
    
    func currentUser(userId : Int64) -> Account {
        let moc = mainManagedObjectContext() as NSManagedObjectContext
        let user = insertOrUpdateUserInMoc(with: userId, moc: moc)
        return user
    }
    
    func mainManagedObjectContext() -> NSManagedObjectContext {
        return CoreDataStack.sharedStack.managedObjectContext
    }
    
    func saveContext()  {
        CoreDataStack.sharedStack.saveContext()
    }
    
    func loadDefaultAccount() -> Account {
        
        if let url = Bundle.main.url(forResource: "Login", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                if let user = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject]{
                    currentAccountUser = insertAccountUserWithProperties(propertyDict: user)
                    return currentAccountUser
                }
            } catch {
                print("error:\(error)")
            }
        }
        return self.currentAccountUser
    }
    
    func insertAccountUserWithProperties(propertyDict : [String  : Any]) -> Account {
        
        let userFetch = NSFetchRequest<NSManagedObject>(entityName: "Account") //Account.fetchRequest()
        let moc = mainManagedObjectContext()
        
        do {
            let fetchedUsers = try moc.fetch(userFetch as! NSFetchRequest<NSFetchRequestResult>)
            var account = Account()
            if fetchedUsers.count == 0 {
                let accountEntity = NSEntityDescription.entity(forEntityName: "Account", in: moc)!
                account = Account(entity: accountEntity, insertInto: moc)
                account.setValue(propertyDict["userName"], forKey: "name")
                account.setValue(propertyDict["pin"], forKey: "pin")
                account.setValue(propertyDict["uid"], forKey: "uid")
                account.setValue(propertyDict["balance"], forKey: "balance")
                account.setValue(false, forKey: "isSignedIn")
            } else {
                account = fetchedUsers.first as! Account
            }
            CoreDataStack.sharedStack.saveContext()
            return account
        } catch {
            fatalError("Failed to fetch Accunts: \(error)")
        }
    }
    
    func transactionEntity() -> Transaction {
        let moc = mainManagedObjectContext()
        let accountEntity = NSEntityDescription.entity(forEntityName: "Transaction", in: moc)!
        let transaction = NSManagedObject(entity: accountEntity, insertInto: moc) as! Transaction
        return transaction
    }
    
    func fetchAccountByManagedObjecID(managedObjectId : NSManagedObjectID) -> Account {
        let moc = mainManagedObjectContext()
        var account = Account ()
        do {
            account = try moc.existingObject(with: managedObjectId) as! Account
        } catch {
            fatalError("Failed to fetch Accunts: \(error)")
        }
        return account
    }
    
    func signOutUser() {
       let user = currentAccountUser
        mainManagedObjectContext().perform {
            user.isSignedIn = false
            user.balance = 10000
            self.saveContext()
        }
    }
    
    func nukeCoreData()  {
        TransactionManager().deleteAllTransactions()
        signOutUser()
    }
}
