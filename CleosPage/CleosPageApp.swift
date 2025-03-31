//
//  CleosPageApp.swift
//  CleosPage
//
//  Created by Jordan McKnight on 3/31/25.
//

import SwiftUI

@main
struct CleosPageApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
