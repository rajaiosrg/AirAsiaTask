//
//  AAUserTests.swift
//  AirAsiaTasskTests
//
//  Created by Raja Earla on 16/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import XCTest
import CoreData

@testable import AirAsiaTassk

class AAUserTests: XCTestCase {
    
    var testsCoreData = TestsCoreDataStorageManager()
    override func setUp() {
        super.setUp()
        loadDefaultAccount()
    }
    
    override func tearDown() {
        flushData()
        super.tearDown()
        
    }
    
    func testUser() {
        let account = fetchAccount(with: 34521, moc: testsCoreData.backgroundContext)
        //Assert: return account
        XCTAssertNotNil( account )
    }
    
    func testRemoveAccount() {
        
        let account = fetchAccount(with: 34521, moc: testsCoreData.backgroundContext)
        testsCoreData.backgroundContext.delete(account)
        
        let deleteAccount = fetchAccount(with: 34521, moc: testsCoreData.backgroundContext)
        XCTAssertNil(deleteAccount)
    }

    
    func backgroundContext() -> NSManagedObjectContext {
       return testsCoreData.backgroundContext
    }
    func mockPersistantContainer() -> NSPersistentContainer {
       return testsCoreData.mockPersistantContainer
    }

    func loadDefaultAccount() {
        
        if let url = Bundle.main.url(forResource: "Login", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                if let user = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject]{
                   _ = insertAccountUserWithProperties(propertyDict: user)
                }
            } catch {
                print("error:\(error)")
            }
        }
    }

    
    func insertAccountUserWithProperties(propertyDict : [String  : Any]) -> Account {
        
        let userFetch = NSFetchRequest<NSManagedObject>(entityName: "Account")
        let moc = backgroundContext()
        
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
            testsCoreData.saveContext()
            return account
        } catch {
            fatalError("Failed to fetch Accounts: \(error)")
        }
    }

    
    func fetchAccount(with userId : Int64 , moc : NSManagedObjectContext) -> Account {
        
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
            return account
        } catch {
            fatalError("Failed to fetch User: \(error)")
        }
    }


    func flushData() {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Account")
        let objs = try! mockPersistantContainer().viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistantContainer().viewContext.delete(obj)
        }
        
        try! mockPersistantContainer().viewContext.save()
    }
    
    func numberOfItemsInPersistentStore() -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Account")
        let results = try! testsCoreData.mockPersistantContainer.viewContext.fetch(request)
        return results.count
    }

}

