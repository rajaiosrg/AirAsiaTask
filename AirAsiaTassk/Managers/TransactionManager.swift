//
//  TransactionManager.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import Foundation
import CoreData

public class TransactionManager {
    
    var transactions : [Transaction] = []
    var coreDataManager = CoreDataManger.sharedManager

    init() {
       transactions = fetchAllTransactions()
    }
    
    func fetchAllTransactions() -> [Transaction] {
        let transactionFetch = NSFetchRequest<NSManagedObject>(entityName: "Transaction")
        let moc = coreDataManager.mainManagedObjectContext()
        do {
            let fetchedTransactions = try moc.fetch(transactionFetch as! NSFetchRequest<Transaction>)
            self.transactions = fetchedTransactions
        } catch {
            fatalError("Failed to fetch Transactions: \(error)")
        }
        return self.transactions
    }
    
    func refreshTransactionsList()  {
        transactions.removeAll()
        transactions = fetchAllTransactions()
    }
    
    func transactionCount() -> Int {
        return self.transactions.count
    }
    
    func deleteAllTransactions() {
        let transactionFetch = NSFetchRequest<NSManagedObject>(entityName: "Transaction")
        let moc = coreDataManager.mainManagedObjectContext()
        do {
            let fetchedTransactions = try moc.fetch(transactionFetch as! NSFetchRequest<Transaction>)
            moc.performAndWait {
                for transaction in fetchedTransactions {
                    moc.delete(transaction)
                }
                self.coreDataManager.saveContext()
            }
        } catch {
            fatalError("Failed to fetch Transactions: \(error)")
        }

    }
}
