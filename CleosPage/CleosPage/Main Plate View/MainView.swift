import SwiftUI

struct MainView: View {
    @Binding var isUserLoggedIn: Bool // Bind login state from RootView
    @State private var notes: [Note] = [] // Dynamic array for memos
    @State private var contacts: [Contact] = [] // Dynamic array for contacts (now uses a custom struct)
    @State private var animationOffsetX: CGFloat = 0 // Controls animation movement
    @State private var isAnimationActive: Bool = false // Controls animation activation
    @State private var isNotePadViewPresented: Bool = false // Controls NotePadView modal
    @State private var isSaveContactViewPresented: Bool = false // Controls SaveContactView modal

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

                // Animation Layer - Positioned above background
                VStack {
                    memoBackgroundAnimation() // Displays memos and contacts in animation
                        .frame(height: 150) // Height for animation layer
                    Spacer()
                }

                VStack(spacing: 40) {
                    // Welcome Title
                    Text("Welcome to Cleo's App")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .shadow(radius: 5)

                    Spacer()

                    // Memo Icon for NotePadView
                    createIcon(
                        systemImage: "note.text",
                        backgroundColor: .blue,
                        action: { isNotePadViewPresented = true }
                    )
                    .sheet(isPresented: $isNotePadViewPresented) {
                        NotePadView(onSaveMemo: addMemo)
                    }

                    // Contact Icon for SaveContactView
                    createIcon(
                        systemImage: "person.crop.circle.badge.plus",
                        backgroundColor: .green,
                        action: { isSaveContactViewPresented = true }
                    )
                    .sheet(isPresented: $isSaveContactViewPresented) {
                        SaveContactView(onSaveContact: addContact)
                    }

                    Spacer()

                    // Logout Button at the Bottom
                    Button(action: {
                        saveData() // Save memos and contacts before logging out
                        isUserLoggedIn = false // Log out and go back to LoginView
                    }) {
                        Text("Logout")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)

                    // Footer Message
                    Text("Manage your memos and contacts effortlessly!")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.bottom, 20)
                }
                .padding(.horizontal, 30)
            }
            .navigationTitle("") // Remove default navigation title
            .navigationBarHidden(true) // Hide navigation bar for a clean view
            .onAppear {
                loadData() // Load saved memos and contacts on app start
            }
        }
    }

    func createIcon(systemImage: String, backgroundColor: Color, action: @escaping () -> Void) -> some View {
        Image(systemName: systemImage)
            .resizable()
            .frame(width: 70, height: 70)
            .foregroundColor(.white)
            .padding(15)
            .background(
                Circle()
                    .fill(backgroundColor) // Circular background color
                    .shadow(radius: 5)
            )
            .onTapGesture(perform: action)
    }

    func memoBackgroundAnimation() -> some View {
        VStack(spacing: 10) {
            // Animation for Memos
            HStack(spacing: 20) {
                ForEach(notes) { note in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Note(text: note.text, color: note.color).getColor())
                        .frame(width: 250, height: 80)
                        .overlay(
                            Text(note.text)
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding()
                        )
                        .offset(x: isAnimationActive ? animationOffsetX : 0)
                }
            }

            // Animation for Contacts
            HStack(spacing: 20) {
                ForEach(contacts) { contact in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.green.opacity(0.7))
                        .frame(width: 250, height: 80)
                        .overlay(
                            VStack {
                                Text("Name: \(contact.name)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("Phone: \(contact.number)")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            }
                            .multilineTextAlignment(.center)
                            .padding()
                        )
                        .offset(x: isAnimationActive ? animationOffsetX : 0)
                }
            }
        }
        .animation(
            isAnimationActive ?
                .linear(duration: 10).repeatForever(autoreverses: false) : .default,
            value: animationOffsetX
        )
        .onTapGesture {
            startAnimation()
        }
    }

    func startAnimation() {
        if !isAnimationActive {
            isAnimationActive = true
            animationOffsetX = UIScreen.main.bounds.width
        }
    }

    func addMemo(_ memo: Note) {
        notes.append(memo) // Add new memo to the animation
    }

    func addContact(_ contact: Contact) {
        contacts.append(contact) // Add new contact to the animation
    }

    func saveData() {
        // Save memos and contacts using UserDefaults
        let encoder = JSONEncoder()
        if let encodedNotes = try? encoder.encode(notes),
           let encodedContacts = try? encoder.encode(contacts) { // Encode contacts as well
            UserDefaults.standard.set(encodedNotes, forKey: "SavedNotes")
            UserDefaults.standard.set(encodedContacts, forKey: "SavedContacts")
        }
    }

    func loadData() {
        // Load memos and contacts from UserDefaults
        let decoder = JSONDecoder()
        if let savedNotes = UserDefaults.standard.data(forKey: "SavedNotes"),
           let savedContacts = UserDefaults.standard.data(forKey: "SavedContacts") {
            if let decodedNotes = try? decoder.decode([Note].self, from: savedNotes) {
                notes = decodedNotes
            }
            if let decodedContacts = try? decoder.decode([Contact].self, from: savedContacts) { // Decode contacts as well
                contacts = decodedContacts
            }
        }
    }
}
