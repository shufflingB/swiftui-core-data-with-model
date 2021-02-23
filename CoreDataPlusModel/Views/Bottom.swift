//
//  NestedOne.swift
//  CoreDataPlusModel
//
//  Created by Jonathan Hume on 06/08/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//

import SwiftUI

struct Bottom: View {
    @EnvironmentObject var model: AppModel
    var body: some View {
        DisplayCounts(
            title: String(describing: Self.self) + " - Data from model",
            itemsTotal: model.allItems.count,
            itemsFlaggedTotal: model.flaggedItems.count,
            isFlaggedItemCountEven: model.isOddNumberItemsFlagged
        ).border(Color.green).padding()
    }
}

struct Bottom_Previews: PreviewProvider {
    static let dummyModel = AppModel(inMemory: true)
    static var previews: some View {
        Bottom()
            .environment(\.managedObjectContext, dummyModel.managedObjectContext)
            .environmentObject(dummyModel)
            .previewLayout(.sizeThatFits)
    }
}
