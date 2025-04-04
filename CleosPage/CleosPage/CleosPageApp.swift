//
//  CleosPageApp.swift
//  CleosPage
//
//  Created by Jordan McKnight on 4/3/25.
//

import SwiftUI
import FirebaseCore

@main
struct CleosPageApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        // Initialize Firebase
        FirebaseApp.configure()
        print("Firebase has been configured!")
       
    }

    var body: some Scene {
        WindowGroup {
            LoginPage()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
