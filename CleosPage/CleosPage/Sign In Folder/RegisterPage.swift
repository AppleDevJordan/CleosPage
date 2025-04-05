import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode // For navigating back
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showSuccessNotification: Bool = false // For displaying success message
    @State private var errorMessage: String? = nil // For validation errors

    var body: some View {
        ZStack {
            // Background Color or Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.orange, Color.red.opacity(0.8), Color.brown]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                // Page Title
                Text("Create an Account")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                // Email Field
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(8)

                // Password Field
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(8)

                // Confirm Password Field
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(8)

                // Error Message
                if let message = errorMessage {
                    Text(message)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding()
                }

                // Register Button
                Button(action: saveUserDetails) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green.opacity(0.8))
                        .cornerRadius(8)
                }

                // Back Button to LoginView
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Navigate back to LoginView
                }) {
                    Text("Back to Login")
                        .foregroundColor(.white)
                        .underline()
                }
            }
            .padding()
            .alert(isPresented: $showSuccessNotification) {
                Alert(
                    title: Text("Success!"),
                    message: Text("Your account has been created successfully."),
                    dismissButton: .default(Text("OK"), action: {
                        presentationMode.wrappedValue.dismiss() // Navigate back after success
                    })
                )
            }
        }
    }

    func saveUserDetails() {
        // Basic validation logic
        guard !email.isEmpty else {
            errorMessage = "Email field is required."
            return
        }
        guard !password.isEmpty else {
            errorMessage = "Password field is required."
            return
        }
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        // Clear error message
        errorMessage = nil

        // Save email and password in UserDefaults (for simplicity)
        let userDefaults = UserDefaults.standard
        userDefaults.set(email, forKey: "UserEmail")
        userDefaults.set(password, forKey: "UserPassword")

        // Trigger success notification
        showSuccessNotification = true
    }
}
