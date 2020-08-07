//
//  NestedOne.swift
//  CoreDataPlusModel
//
//  Created by Jonathan Hume on 06/08/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//

import SwiftUI

struct DeeplyNested: View {
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
        DisplayCounts(
            title: String(describing: Self.self),
            itemsTotal: allItems.count,
            itemsFlaggedTotal: flaggedItemsFromManagedObjectContext.count,
            itemFirstFlaggedId: "Need setting in Top"
        )
    }
}




struct NestedViaModel: View {
    @EnvironmentObject var model: AppModel
    var body: some View {
        DeeplyNested().environment(\.managedObjectContext, model.managedObjectContext)
//        DisplayCounts(
//            title: String(describing: Self.self),
//            itemsTotal: allItems.count,
//            itemsFlaggedTotal: flaggedItemsFromManagedObjectContext.count,
//            itemFirstFlaggedId: "Need setting in Top"
//        )
    }
}

struct NestedOne_Previews: PreviewProvider {
    static var previews: some View {
        NestedViaModel()
    }
}
