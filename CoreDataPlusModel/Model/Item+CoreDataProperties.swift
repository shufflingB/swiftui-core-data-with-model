//
//  Item+CoreDataProperties.swift
//  CoreDataPlusModel
//
//  Created by Jonathan Hume on 07/08/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {
    
    // MARK: - NSFetchRequests for Items
    @nonobjc public class func fetchItemsAll() -> NSFetchRequest<Item> {
        let name = "\(Self.self)"
        print("Running fetch request \(name) for all")
        let request = NSFetchRequest<Item>(entityName: name)
        request.sortDescriptors = []
        return request
    }

    @nonobjc public class func fetchItemsFlagged() -> NSFetchRequest<Item> {
        let name = "\(Self.self)"
        print("Running fetch request \(name) for flagged")
        let request = NSFetchRequest<Item>(entityName: name)
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "flag == YES")
        return request
    }
    
    
    @NSManaged public var flag: Bool

}

extension Item : Identifiable {

}
