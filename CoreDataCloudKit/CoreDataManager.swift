//
//  CoreDataManager.swift
//  CoreDataCloudKit
//
//  Created by Luke Allen on 12/13/19.
//  Copyright © 2019 Luke Allen. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "CoreDataCloudKit")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static var managedContext: NSManagedObjectContext {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
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

extension CoreDataManager {
    
    static func saveTeslaProduct(name: String?, variant: String?, price: Int?) {
        let product = TeslaProduct(context: managedContext)
        product.name = name
        product.variant = variant
        product.price = Int32(price ?? 0)
        CoreDataManager.shared.saveContext()
    }
    
}
