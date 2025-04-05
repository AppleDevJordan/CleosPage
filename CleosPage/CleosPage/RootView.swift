//
//  RootView.swift
//  CleosPage
//
//  Created by Jordan McKnight on 4/4/25.
//


import SwiftUI

struct RootView: View {
    @State private var isUserLoggedIn: Bool = false // Tracks login state

    var body: some View {
        if isUserLoggedIn {
            MainView(isUserLoggedIn: $isUserLoggedIn)
        } else {
            LoginView(isLoginSheetPresented: .constant(false), isUserLoggedIn: $isUserLoggedIn)
        }
    }
}
