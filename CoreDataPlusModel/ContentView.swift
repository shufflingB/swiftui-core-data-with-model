//
//  ContentView.swift
//  CoreDataPlusModel
//
//  Created by Jonathan Hume on 02/08/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//

import CoreData
import SwiftUI

extension ContentView {
    class Model: ObservableObject {
        @Environment(\.managedObjectContext) var moc

        init() {
            print("Model")
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "flag == YES")) var flaggedItems: FetchedResults<Item>
    @FetchRequest(sortDescriptors: []) var allItems: FetchedResults<Item>

    init() {
        print("CurrentView")
        print(moc)
    }

    var firstFlagged: Item? {
        switch flaggedItems.count {
        case 1:
            // os_log("Using existing root item", type: .debug)
            return flaggedItems[0]
        case ...0, nil:
            print("No root Items detected")
            return nil
        default:
            print("Unexpected number of Root Items found (%d) in CoreData store. Using the first one but should only be one", flaggedItems.count)
            return flaggedItems[0]
        }
    }

    var body: some View {
        VStack {
            HStack { Text("Total items = \(allItems.count)")
                Text("Flagged items \(flaggedItems.count)")
            }
            Text("First flagged = " + String(firstFlagged.hashValue))
            Spacer()
            Button(action: {
                print("Pressed add")
                _ = Item(context: self.moc)
            }) {
                Text("Add Ordinary Item")
                    .padding()
            }
            Button(action: {
                print("Pressed add flagged")
                let newItem = Item(context: self.moc)
                newItem.flag = true
            }) {
                Text("Add Flagged Item")
                    .padding()
            }
            Button(action: {
                print("Pressed delete the lot")
                _ = allItems.map({ item in self.moc.delete(item as NSManagedObject) })
            }) {
                Text("Delete all")
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        return ContentView().environment(\.managedObjectContext, moc)
    }
}
