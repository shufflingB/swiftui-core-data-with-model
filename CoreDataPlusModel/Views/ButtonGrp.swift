//
//  ButtonGrp.swift
//  CoreDataPlusModel
//
//  Created by Jonathan Hume on 06/08/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//

import SwiftUI

struct ButtonGrp: View {
    let itemAddFn: () -> Void
    let itemAddFlaggedFn: () -> Void
    let itemsDeleteAllFn: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button(action: itemAddFn) {
                    Text("Add Ordinary Item")
                }
                .padding(5)

                Spacer()

                Button(action: itemAddFlaggedFn) {
                    Text("Add Flagged Item")
                }
                .padding(5)
            }
            Button(action: itemsDeleteAllFn) {
                Text("Delete all").accentColor(.red)
            }
            .padding(5)
        }
    }
}

struct ButtonGrp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonGrp(
            itemAddFn: { print("itemAdd pressed") },
            itemAddFlaggedFn: { print("iteamAdd flagged pressed") },
            itemsDeleteAllFn: { print("Delete all items pressed") })
            .previewLayout(.sizeThatFits)
    }
}
