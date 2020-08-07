//
//  ContentView.swift
//  CoreDataPlusModel
//
//  Created by Jonathan Hume on 02/08/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//

import CoreData
import SwiftUI

struct Home: View {
    // These fetches will get their data via the Environment's managedObjectContext set on
    // the view.
    @Environment(\.managedObjectContext)  var moc
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "flag == YES")
    ) var flaggedItemsFromManagedObjectContext: FetchedResults<Item>
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: []
    ) var allItems: FetchedResults<Item>

    var body: some View {
        VStack {
        VStack {
            DisplayCounts(
                title: String(describing: Self.self),
                itemsTotal: allItems.count,
                itemsFlaggedTotal: flaggedItemsFromManagedObjectContext.count,
                itemFirstFlaggedId: "Need setting in Top"
            )
            ButtonGrp(
                itemAddFn: {
                    _ = Item(context: moc)
                },
                itemAddFlaggedFn: {
                    let newItem = Item(context: moc)
                    newItem.flag = true
                },
                itemsDeleteAllFn: {
                    _ = allItems.map({ item in moc.delete(item as NSManagedObject) })
                })
        }
        .border(Color.black)
        }
    }
}
