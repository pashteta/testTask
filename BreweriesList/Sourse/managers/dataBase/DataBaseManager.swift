//
//  DataBaseManager.swift
//  BreweriesList
//
//  Created by User on 4/14/20.
//  Copyright © 2020 User. All rights reserved.
//

import CoreData

private var cNameEntity = "Breweries"

class DataBaseManager: NSObject {
    
    static let shared = DataBaseManager()
    private var storeContainer: NSPersistentContainer
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    // MARK: - Initial
    
    private override init() {
        self.storeContainer = NSPersistentContainer(name: cNameEntity)
        self.storeContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("CORE DATA ERROR -> \(error), \(error.userInfo)")
            }
        })
    }
    
    // MARK: - Context
    
    func saveContext () {
        let context = self.storeContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("CORE DATA ERROR -> \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
