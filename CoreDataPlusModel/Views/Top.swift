//
//  ContentView.swift
//  CoreDataPlusModel
//
//  Created by Jonathan Hume on 02/08/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//

import CoreData
import SwiftUI

struct Top: View {
    @EnvironmentObject var model: AppModel

    @FetchRequest(
        fetchRequest: Item.fetchItemsFlagged()
    ) var flaggedItemsFromManagedObjectContext: FetchedResults<Item>
    @FetchRequest(
        fetchRequest: Item.fetchItemsAll()
    ) var allItemsFromManagedObjectContext: FetchedResults<Item>

    var body: some View {
        VStack {
            VStack {
                // Demo getting data from the moc using FetchRequest
                DisplayCounts(
                    title: String(describing: Self.self) + " - Data from moc",
                    itemsTotal: allItemsFromManagedObjectContext.count,
                    itemsFlaggedTotal: flaggedItemsFromManagedObjectContext.count,
                    isFlaggedItemCountEven: flaggedItemsFromManagedObjectContext.count % 2 == 0
                )

                // Demo getting the same data as in FetchRequest, but from the App's model
                DisplayCounts(
                    title: String(describing: Self.self) + " - Data from model",
                    itemsTotal: model.allItems.count,
                    itemsFlaggedTotal: model.flaggedItems.count,
                    isFlaggedItemCountEven: model.isOddNumberItemsFlagged
                ).padding()

                // Call down through to demo no need for 'prop' drilling, or rather in SwiftUI var
                // drilling.
                EmptyMiddle()

                ButtonGrp(
                    itemAddFn: model.addItem,
                    itemAddFlaggedFn: model.addItemFlagged,
                    saveAllFn: model.saveContext,
                    itemsDeleteAllFn: model.itemsDeleteAll)
            }
            .border(Color.black)
        }
    }
}

struct Top_Previews: PreviewProvider {
    static let dummyModel = AppModel(inMemory: true)
    static var previews: some View {
        Top()
            .environment(\.managedObjectContext, dummyModel.managedObjectContext)
            .environmentObject(dummyModel)
    }
}
