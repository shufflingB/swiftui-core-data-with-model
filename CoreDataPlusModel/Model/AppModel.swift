//
//  Model.swift
//  CoreDataPlusModel
//
//  Created by Jonathan Hume on 04/08/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//

import CoreData

class AppModel: ObservableObject {
    
    var managedObjectContext: NSManagedObjectContext {
        print("AppModel returning moc")
        return CoreDataInstance.shared.persistentContainer.viewContext
    }
    
    /*
     https://stackoverflow.com/questions/58794088/using-fetchrequestentity-for-swiftui-macos-app-crashes
     // outside of the view
     func getAllNotes() -> NSFetchRequest<Note> {
       let request: NSFetchRequest<Note> = Note.fetchRequest()
       request.sortDescriptors = []
       return request
     }

     // in the view
     @FetchRequest(fetchRequest: getAllNotes()) var notes: FetchedResults<Note>
     */

    /*
     
     
     var firstFlagged: Item? {
         switch flaggedItemsFromManagedObjectContext.count {
         case 1:
             // os_log("Using existing root item", type: .debug)
             return flaggedItemsFromManagedObjectContext[0]
         case ...0, nil:
             print("No root Items detected")
             return nil
         default:
             print("Unexpected number of Root Items found %d in CoreData store. Using the first one but should only be one", flaggedItemsFromManagedObjectContext.count)
             return flaggedItemsFromManagedObjectContext[0]
         }
     }
       private static var _persistentContainer: NSPersistentContainer?

       static func persistentContainer() -> NSPersistentContainer {
           if _persistentContainer == nil {
               print("Initialising container")
               /*
                 The persistent container for the application. This implementation
                 creates and returns a container, having loaded the store for the
                 application to it. This property is optional since there are legitimate
                 error conditions that could cause the creation of the store to fail.
                */
               _persistentContainer = NSPersistentContainer(name: "AppCoreData")
               _persistentContainer?.loadPersistentStores(completionHandler: { _, error in
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
           }

           print("Returning container ...")
           return _persistentContainer!
       }

       var managedObjectContext: NSManagedObjectContext {
           AppModel.persistentContainer().viewContext
       }
     */

    /*
     var itemsAll: [Item] = {
         do {
             let items = try shared!.managedObjectContext.fetch(Item.fetchRequest())
             return items as! [Item]
         } catch let error as NSError {
             print("Error getting ShoppingItems: \(error.localizedDescription), \(error.userInfo)")
         }
         return [Item]()
     }()

         func saveContext() {
             let context = persistentContainer.viewContext
             if context.hasChanges {
                 do {
                     try context.save()
                 } catch {
                     // Replace this implementation with code to handle the error appropriately.
                     // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                     let nserror = error as NSError
                     fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                 }
             }
         }
      */
}
