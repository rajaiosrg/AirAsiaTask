//
//  TransactionsTests.swift
//  AirAsiaTasskTests
//
//  Created by Raja Earla on 16/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import XCTest
import CoreData
@testable import AirAsiaTassk


class TransactionsTests: XCTestCase {
    
    var testsCoreData = TestsCoreDataStorageManager()
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        flushData()
        super.tearDown()        
    }
    
    func  testInsertTransaction()  {
        
        let uuid = arc4random_uniform(100000) + 1

        let transaction = CoreDataManger.sharedManager.transactionEntity()
        transaction.transactionAmount = 100
        transaction.transactionId = Int64(uuid)
        transaction.beneficiary = "Raja"
        transaction.transferer = "Ganesh"
        transaction.transactionType = TransactionType.Debit.rawValue
        transaction.transactionDesc = "Gift"
        transaction.beneficiaryNumber = "8884020547"
        // Save data
        testsCoreData.saveContext()

        let fetchedTransaction = fetchTransactionWithTransactionID(transactionID: Int64(uuid))
        XCTAssertNotNil(fetchedTransaction )
    }

    func backgroundContext() -> NSManagedObjectContext {
        return testsCoreData.backgroundContext
    }
    func mockPersistantContainer() -> NSPersistentContainer {
        return testsCoreData.mockPersistantContainer
    }
    
    func transactionEntity() -> Transaction {
        let moc = backgroundContext()
        let accountEntity = NSEntityDescription.entity(forEntityName: "Transaction", in: moc)!
        let transaction = NSManagedObject(entity: accountEntity, insertInto: moc) as! Transaction
        return transaction
    }
    
    func fetchTransactionWithTransactionID(transactionID : Int64) -> Transaction {
        let userFetch = NSFetchRequest<NSManagedObject>(entityName: "Transaction")
        userFetch.predicate = NSPredicate(format: "transactionId == %lld", transactionID)
        let moc = backgroundContext()
        var account = Transaction()
        do {
            let fetchedUsers = try moc.fetch(userFetch as! NSFetchRequest<NSFetchRequestResult>)
            
            if fetchedUsers.count == 0 {
                let accountEntity = NSEntityDescription.entity(forEntityName: "Transaction", in: moc)!
                account = NSManagedObject(entity: accountEntity, insertInto: moc) as! Transaction
            } else {
                account = fetchedUsers.first as! Transaction
            }
            return account
        } catch {
            fatalError("Failed to fetch Transaction: \(error)")
        }
    }

    func flushData() {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Transaction")
        let objs = try! mockPersistantContainer().viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistantContainer().viewContext.delete(obj)
        }
        try! mockPersistantContainer().viewContext.save()
    }
}
