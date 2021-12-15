//
//  LCARS_calculatorApp.swift
//  LCARS_watch WatchKit Extension
//
//  Created by Andrew Lewis on 12/14/21.
//  Copyright © 2021 Andrew Lewis. All rights reserved.
//

import SwiftUI

@main
struct LCARS_calculatorApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
