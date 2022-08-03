//
//  LCARS_calcApp.swift
//  LCARS calc
//
//  Created by Andy Lewis on 8/2/22.
//

import SwiftUI

@main
struct LCARS_calcApp: App {
    let persistenceController = PersistenceController.shared
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
