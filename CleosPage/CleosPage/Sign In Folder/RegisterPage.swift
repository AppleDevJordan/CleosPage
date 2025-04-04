import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
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
                
                // Register Button
                Button(action: {
                    // Registration logic goes here
                }) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green.opacity(0.8))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}
