//
//  CoreDataPlusModelApp.swift
//  CoreDataPlusModel
//
//  Created by Jonathan Hume on 03/08/2020.
//  Copyright © 2020 Jonathan Hume. All rights reserved.
//

import CoreData
import os.log
import SwiftUI

@main
struct CoreDataPlusModelApp: App {
    @Environment(\.scenePhase) private var scenePhase

    /* Create an instance of the model wrapped by @StateObject to indicate to SwiftUI that
     this part of of the app's state is owned by this component in the hierarchy.

     StateObject instantiates once just before view is rendered and expires automatically when
     the container it is part of is removed. NB: this removes need for creating Singleton.
     */
    @StateObject private var model = AppModel()

    var body: some Scene {
        /* Want to demo both approachs so add the MOC to the environment so that @FetchRequest
         works in child views. Add the model Object to the environment so that we can get hold
         of its capabilites */
        WindowGroup {
            Top()
                .environment(\.managedObjectContext, model.managedObjectContext)
                .environmentObject(model)
        }

        /* Possible bug: Doesn't do anything as of XCode 12.0 beta 4 . See
         https://developer.apple.com/forums/thread/650632
         */
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("App going active")
            case .inactive:
                print("App going inactive")
            case .background:
                print("App going into background")
                model.saveContext()
            default:
                print("Unknown type of scenePhase")
            }
        }
    }
}
