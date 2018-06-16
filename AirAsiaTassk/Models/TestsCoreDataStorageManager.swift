//
//  TestsCoreDataStorageManager.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 16/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import Foundation
import CoreData

class TestsCoreDataStorageManager  {

    
    //MARK: mock in-memory persistant store
   public lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
   public lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "AirAsia", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.mockPersistantContainer.newBackgroundContext()
    }()
    
    init() {
        self.mockPersistantContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func insertUser( name: String, finished: Bool ) -> Account? {
        
        guard let account = NSEntityDescription.insertNewObject(forEntityName: "Account", into: backgroundContext) as? Account else { return nil }
        account.name = name
        
        return account
    }
    
    func fetchAll() -> [Account] {
        let request: NSFetchRequest<Account> = Account.fetchRequest()
        let results = try? mockPersistantContainer.viewContext.fetch(request)
        return results ?? [Account]()
    }
    
    func remove( objectID: NSManagedObjectID ) {
        let obj = backgroundContext.object(with: objectID)
        backgroundContext.delete(obj)
    }
    
    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }
    
    func saveContext () {
        let context = mockPersistantContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
