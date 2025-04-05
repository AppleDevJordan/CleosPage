import SwiftUI

struct SaveContactView: View {
    @Environment(\.presentationMode) var presentationMode // To dismiss the view
    @State private var contactName: String = "" // Contact name input
    @State private var phoneNumber: String = "" // Phone number input
    var onSaveContact: (Contact) -> Void // Closure expecting a Contact struct

    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("Save Contact")
                .font(.largeTitle)
                .bold()
                .padding()

            // Input for Contact Name
            VStack(alignment: .leading) {
                Text("Contact Name")
                    .font(.headline)
                TextField("Enter contact name", text: $contactName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }

            // Input for Phone Number
            VStack(alignment: .leading) {
                Text("Phone Number")
                    .font(.headline)
                TextField("Enter phone number", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .keyboardType(.phonePad)
            }

            // Save Button
            Button(action: saveContact) {
                Text("Save Contact")
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.blue)
                    .cornerRadius(8)
            }

            Spacer()
        }
        .padding()
    }

    func saveContact() {
        // Ensure input fields are not empty
        guard !contactName.isEmpty, !phoneNumber.isEmpty else { return }
        
        // Create a new Contact struct and pass it back via the closure
        let newContact = Contact(name: contactName, number: phoneNumber)
        onSaveContact(newContact)
        presentationMode.wrappedValue.dismiss() // Dismiss the view
    }
}
