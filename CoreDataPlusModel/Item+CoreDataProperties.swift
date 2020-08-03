//
//  Item+CoreDataProperties.swift
//  CoreDataPlusModel
//
//  Created by Jonathan Hume on 02/08/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//
//

import CoreData
import Foundation

extension Item {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var flag: Bool
}
