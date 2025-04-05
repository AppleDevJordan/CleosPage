import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices


struct LoginView: View {
    @Binding var isLoginSheetPresented: Bool
    @Binding var isUserLoggedIn: Bool // Bind to login state
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isRegisterViewPresented: Bool = false // Controls navigation to RegisterView
    @State private var isEULAPresented: Bool = false // Controls the EULA view

    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    // App Title
                    Text("Login to Cleo's App")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    // Email Field
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .autocapitalization(.none)

                    // Password Field
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    // Login Button
                    Button(action: loginUser) {
                        Text("Login")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)

                    // Google Sign-In Button
                    GoogleSignInButton(action: handleGoogleSignIn)
                        .frame(height: 50)
                        .padding(.horizontal)

                    // Apple Sign-In Button
                    SignInWithAppleButton(.signIn) { request in
                        handleAppleSignIn(request: request)
                    } onCompletion: { result in
                        handleAppleSignInCompletion(result: result)
                    }
                    .frame(height: 50)
                    .padding(.horizontal)

                    // Register Button
                    Button(action: {
                        isRegisterViewPresented = true // Navigate to RegisterView
                    }) {
                        Text("Create an Account")
                            .foregroundColor(.white)
                            .underline()
                    }
                    .sheet(isPresented: $isRegisterViewPresented) {
                        RegisterView()
                    }

                    // EULA Button
                    Button(action: {
                        isEULAPresented = true // Show EULA
                    }) {
                        Text("View EULA")
                            .foregroundColor(.white)
                            .underline()
                    }
                    .sheet(isPresented: $isEULAPresented) {
                        EULAView() // Displays the EULA
                    }

                    Spacer()
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }

    func loginUser() {
        guard !email.isEmpty, !password.isEmpty else {
            alertMessage = "Please fill in both fields."
            showAlert = true
            return
        }

        // Simulate login logic here (e.g., Firebase authentication)
        if email == UserDefaults.standard.string(forKey: "UserEmail") && password == UserDefaults.standard.string(forKey: "UserPassword") {
            isUserLoggedIn = true
            isLoginSheetPresented = false // Dismiss LoginView on success
        } else {
            alertMessage = "Invalid email or password."
            showAlert = true
        }
    }

    func handleGoogleSignIn() {
        // Handle Google Sign-In (add Firebase integration here if needed)
        isUserLoggedIn = true // Mock successful sign-in
    }

    func handleAppleSignIn(request: ASAuthorizationAppleIDRequest) {
        // Configure Apple Sign-In Request
        request.requestedScopes = [.email, .fullName]
    }

    func handleAppleSignInCompletion(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success:
            isUserLoggedIn = true // Mock successful Apple Sign-In
        case .failure(let error):
            alertMessage = "Apple Sign-In failed: \(error.localizedDescription)"
            showAlert = true
        }
    }
}
