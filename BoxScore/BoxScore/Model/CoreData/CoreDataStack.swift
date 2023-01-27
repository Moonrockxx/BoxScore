//
//  CoreDataStack.swift
//  BoxScore
//
//  Created by TomF on 26/01/2023.
//

import Foundation
import CoreData

class CoreDataStack {
    
    // MARK: - Singleton
    static let shared: CoreDataStack = CoreDataStack(modelName: "Boxscore")
    var persistentContainer: NSPersistentContainer
    
    // MARK: - Variables
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Init
    init(modelName: String, persistentStoreDescription: String? = nil) {
        let description = NSPersistentStoreDescription()
        if let persistentStoreDescription {
            description.url = URL(fileURLWithPath: persistentStoreDescription)
        }
        
        persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            guard let unwrappedError = error else { return }
            fatalError("Unresolved error \(unwrappedError.localizedDescription)")
        })
        
    }
}
