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
    let saveAllFn: () -> Void
    let itemsDeleteAllFn: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button(action: itemAddFn) {
                    Text("Add Ordinary")
                }
                .padding(5)

                Spacer()

                Button(action: itemAddFlaggedFn) {
                    Text("Add Flagged")
                }
                .padding(5)
            }
            HStack {
                Button(action: saveAllFn) {
                    Text("Save")
                }
                .padding(5)

                Spacer()

                Button(action: itemsDeleteAllFn) {
                    Text("Delete all").accentColor(.red)
                }
                .padding(5)
            }
        }
    }
}

struct ButtonGrp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonGrp(
            itemAddFn: { print("itemAdd pressed") },
            itemAddFlaggedFn: { print("iteamAdd flagged pressed") },
            saveAllFn: { print("Save all items pressed") },
            itemsDeleteAllFn: { print("Delete all items pressed") }
        )

        .previewLayout(.sizeThatFits)
    }
}
