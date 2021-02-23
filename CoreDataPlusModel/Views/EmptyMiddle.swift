//
//  EmptyMiddle.swift
//  CoreDataPlusModel
//
//  Created by Jonathan Hume on 07/08/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//

import SwiftUI

struct EmptyMiddle: View {
    var body: some View {
        VStack {
            Text("Hello, I'm the empty middle that just calls Bottom view")
                .font(.headline)
            Bottom()
        }
        .border(Color.blue)
    }
}

struct EmptyMiddle_Previews: PreviewProvider {
    static let dummyModel = AppModel(inMemory: true)
    static var previews: some View {
        EmptyMiddle()
            .environment(\.managedObjectContext, dummyModel.managedObjectContext)
            .environmentObject(dummyModel)
            .previewLayout(.sizeThatFits)
    }
}
