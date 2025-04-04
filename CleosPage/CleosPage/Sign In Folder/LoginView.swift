import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices // Required for Apple Sign-In

struct LoginPage: View {
    
    @State private var currentNonce: String? = nil
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
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
                    
                    // Register Navigation Link
                    NavigationLink(destination: RegisterView()) {
                        Text("Don't have an account? Register")
                            .foregroundColor(.white)
                            .underline()
                    }
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
        
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                alertMessage = error.localizedDescription
                showAlert = true
            } else {
                alertMessage = "Login Successful!"
                showAlert = true
            }
        }
    }
    
    func handleGoogleSignIn() {
        // Google Sign-In logic (already implemented)
    }
    
    func handleAppleSignIn(request: ASAuthorizationAppleIDRequest) {
        // Generate the random nonce
        let nonce = randomNonceString()
        currentNonce = nonce // Store the nonce for Firebase validation
        
        // Pass the hashed nonce to the Apple request
        request.requestedScopes = [.email, .fullName]
        request.nonce = sha256(nonce) // Hash the nonce before passing it
    }
    
    
    func handleAppleSignInCompletion(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
                  let identityToken = appleIDCredential.identityToken,
                  let tokenString = String(data: identityToken, encoding: .utf8),
                  let nonce = currentNonce else { // Use the stored nonce here
                alertMessage = "Apple Sign-In Failed"
                showAlert = true
                return
            }
            
            // Create Firebase credential
            let credential = OAuthProvider.credential(
                withProviderID: "apple.com",
                idToken: tokenString,
                rawNonce: nonce // Pass the valid nonce here
            )
            
            // Sign in to Firebase
            Auth.auth().signIn(with: credential) { _, error in
                if let error = error {
                    alertMessage = "Firebase Sign-In Failed: \(error.localizedDescription)"
                    showAlert = true
                } else {
                    alertMessage = "Apple Sign-In Successful!"
                    showAlert = true
                }
            }
        case .failure(let error):
            alertMessage = "Apple Sign-In Error: \(error.localizedDescription)"
            showAlert = true
        }
    }
}
