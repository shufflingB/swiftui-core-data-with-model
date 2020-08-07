//
//  CoreDataInstance.swift
//  CoreDataPlusModel
//
//  Created by Jonathan Hume on 07/08/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//

import CoreData
/*
 This is based on code here https://developer.apple.com/forums/thread/650876?answerId=620207022#620207022
  except I've removed the both the lazy var and singleton stuff as I don't think either of those are
  necessary when the the object is instantiated via the @StateObject as this:
  1. Causes instantiation just before the view that it is contained in is rendered => use of lazy is not needed
  2. Is only created one within the hierarchy that it is used in => no need for singleton stuff
 */

class CoreDataInstance {
    /*
     Define singleton as per https://www.hackingwithswift.com/example-code/language/what-is-a-singleton
     */
    static let shared = CoreDataInstance()
    private init() {
        print("====> Core data instantiated")
    }

    /*
      Set up access to our Core Data stack
     */
    var persistentContainer: NSPersistentContainer = {
        /*
          The persistent container for the application. This implementation
          creates and returns a container, having loaded the store for the
          application to it. This property is optional since there are legitimate
          error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "AppCoreData")
        container.loadPersistentStores(completionHandler: { _, error in
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
        print("Returning container ...")
        return container
    }()

    static var viewContext: NSManagedObjectContext {
        
        return shared.persistentContainer.viewContext
    }
}
