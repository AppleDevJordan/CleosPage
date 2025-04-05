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
    @State private var isLoginSheetPresented: Bool = true // Control the LoginView sheet
    
    init() {
        // Initialize Firebase
        FirebaseApp.configure()
        print("Firebase has been configured!")
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
