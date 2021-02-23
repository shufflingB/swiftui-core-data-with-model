//
//  Model.swift
//  CoreDataPlusModel
//
//  Created by Jonathan Hume on 04/08/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//

import Combine
import CoreData
import SwiftUI

/**
 NB: No need to use Singleton pattern in SwiftUI as it will be created in conjuction with the the @StateObject wrapper
 that instantiates only once and does so just before View is rendered.

 Indeed, my experience with @StateObject and a standard singleton pattern setup of Core Data persistentContainer that
 used lazy var loading, was that the combination caused CoreData not to setup quite correctly - which while the
 app would compile and appeared to work as expected, also generated a shed load of warning messages.
 */
class AppModel: ObservableObject {
    @Published var allItems = [Item]()
    @Published var flaggedItems = [Item]()

    // No need for @Published as a property derived from an existing @Published property is itself
    // autmatically @Published.
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    // Stupid simple demo of business logic based derived from Core Data, again no need for @Published wrapping
    var isOddNumberItemsFlagged: Bool {
        flaggedItems.count % 2 == 0
    }

    // MARK: - Core Data state mutations.

    func addItem() {
        _ = Item(context: managedObjectContext)
    }

    func addItemFlagged() {
        let newItem = Item(context: managedObjectContext)
        newItem.flag = true
    }

    func itemsDeleteAll() {
        _ = allItems.map({ item in managedObjectContext.delete(item as NSManagedObject) })
    }

    func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                print("Saving data")
                try managedObjectContext.save()
            } catch {
                /* This is straight out of Apple's default implementation. As such Apple advises to replace
                 this implementation with code to handle the error appropriately.
                 In particular fatalError() will causes the application to generate a crash log and terminate.
                 And as such, you are advised not use this function in a shipping application, although it may be useful during development.
                 */
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private var cancellableSet: Set<AnyCancellable> = []

    
    let persistentContainer: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "AppCoreData")
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        
        
        
        print("Setting up Core Data update subscriptions  ")
        CoreDataPublisher(request: Item.fetchItemsAll(), context: persistentContainer.viewContext)
            .sink(
                receiveCompletion: {
                    print("Completion from fetchItemsAll")
                    print($0)
                },
                receiveValue: { [weak self] items in
                    self?.allItems = items
                })
            .store(in: &cancellableSet)

        CoreDataPublisher(request: Item.fetchItemsFlagged(), context: persistentContainer.viewContext)
            .sink(
                receiveCompletion: {
                    print("Completion from fetchItemsFlagged")
                    print($0)
                },
                receiveValue: { [weak self] items in
                    self?.flaggedItems = items
                })
            .store(in: &cancellableSet)
    }
}
