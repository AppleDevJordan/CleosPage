//
//  SettingsView.swift
//  CleosPage
//
//  Created by Jordan McKnight on 4/3/25.
//


import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @State private var isNotificationsEnabled: Bool = true
    @State private var selectedTheme: String = "Light"
    let themes = ["Light", "Dark", "System Default"]
    
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.black.opacity(0.5)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                // Page Title
                Text("Settings")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding()

                // Notifications Toggle
                Toggle(isOn: $isNotificationsEnabled) {
                    Text("Enable Notifications")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(8)

                // Theme Picker
                VStack {
                    Text("Select Theme")
                        .foregroundColor(.white)
                        .font(.title2)
                    Picker("Theme", selection: $selectedTheme) {
                        ForEach(themes, id: \.self) { theme in
                            Text(theme).tag(theme)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(8)

                // Logout Option (Optional)
                Button(action: logoutUser) {
                    Text("Logout")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(8)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
    }
    
    func logoutUser() {
        // Logic for signing out the user
        do {
            try Auth.auth().signOut()
            print("User successfully logged out!")
            // Redirect to LoginPage or Exit
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
