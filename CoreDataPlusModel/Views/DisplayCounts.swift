//
//  DisplayCounts.swift
//  CoreDataPlusModel
//
//  Created by Jonathan Hume on 06/08/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//

import SwiftUI

struct DisplayCounts: View {
    let title: String
    let itemsTotal: Int
    let itemsFlaggedTotal: Int
    let itemFirstFlaggedId: String?

    var body: some View {
        VStack {
            VStack {
                Text("Inside \(title)")
                    .font(.headline)

                Text("Total items = \(itemsTotal), Flagged items \(itemsFlaggedTotal), First flagged = \(itemFirstFlaggedId ?? "N/A")")
                    .font(.subheadline)
            }
        }
    }
}

struct DisplayCounts_Previews: PreviewProvider {
    static var previews: some View {
        DisplayCounts(
            title: "dummyComponent",
            itemsTotal: 5,
            itemsFlaggedTotal: 3,
            itemFirstFlaggedId: "dummyId"
        )
        .previewLayout(.sizeThatFits)
    }
}
