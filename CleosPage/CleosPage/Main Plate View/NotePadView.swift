import SwiftUI

struct NotePadView: View {
    @Environment(\.presentationMode) var presentationMode // Allows dismissing the view
    @State private var newNote: String = "" // Input for new memo
    @State private var selectedColor: String = "yellow" // Default color for memo
    let onSaveMemo: (Note) -> Void // Closure to send memo back to MainView

    let availableColors: [String] = ["yellow", "blue", "green", "orange", "purple"]

    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("Notepad")
                .font(.largeTitle)
                .bold()
                .padding()

            // Input Field for Memo
            HStack {
                TextField("Write your memo here...", text: $newNote)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: .infinity)

                // Save Button
                Button(action: saveMemo) {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)

            // Color Picker
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(availableColors, id: \.self) { colorName in
                        Circle()
                            .fill(Note(text: "", color: colorName).getColor())
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: selectedColor == colorName ? 4 : 0)
                            )
                            .onTapGesture {
                                selectedColor = colorName
                            }
                    }
                }
                .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
    }

    func saveMemo() {
        guard !newNote.isEmpty else { return } // Prevent saving empty memos
        let memo = Note(text: newNote, color: selectedColor)
        onSaveMemo(memo) // Pass memo back to MainView
        presentationMode.wrappedValue.dismiss() // Dismiss NotePadView
    }
}
