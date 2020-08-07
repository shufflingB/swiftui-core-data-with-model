//
//  CoreDataPlusModelApp.swift
//  CoreDataPlusModel
//
//  Created by Jonathan Hume on 03/08/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//

import os.log
import SwiftUI

@main
struct CoreDataPlusModelApp: App {
    @Environment(\.scenePhase) private var scenePhase
    var moc = CoreDataInstance.shared.persistentContainer.viewContext
    
    //@StateObject private var model = AppModel()
    // @StateObject Instantiates just once just before view is rendered and expires automatically when container it is part of is removed.

    var body: some Scene {
        WindowGroup {
            Home().environment(\.managedObjectContext, moc)
        }
        // This may be broken because of a bug, see
        // https://developer.apple.com/forums/thread/650632
        // have logged bug.
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("App going active")

            case .inactive:
                print("App going inactive")
            case .background:

                print("App going into background")
//                saveContext()
            default:
                print("Unknown type of scenePhase")
            }
        }
    }
}
