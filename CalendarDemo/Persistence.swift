//
//  Persistence.swift
//  CalendarDemo
//
//  Created by taro.hiraishi on 2023/04/10.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CalendarDemo")
        if inMemory {
            container.persistentStoreDescriptions.first?.url! = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error) \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
    }
}
