import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var names: [String]
    @State private var newName: String = ""
    let category: String

    init(category: String) {
        self.category = category
        self._names = State(initialValue: NotificationData.getNames(for: category))
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit names for \(category)")) {
                    ForEach(names.indices, id: \.self) { index in
                        HStack {
                            TextField("Name", text: $names[index])
                            if names.count > 1 {
                                Button(action: { names.remove(at: index) }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }

                    HStack {
                        TextField("Add new name", text: $newName)
                        Button(action: addName) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }

                // ⚡ Reset Button Section
                Section {
                    Button("Reset to Defaults") {
                        resetToDefaults()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Edit Names")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveNames()
                        dismiss()
                    }
                }
            }
        }
    }

    private func addName() {
        let trimmed = newName.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        names.append(trimmed)
        newName = ""
    }

    private func saveNames() {
        let key: String
        switch category {
        case "Women": key = "WomenNames"
        case "Men": key = "MenNames"
        case "Women (Friends)": key = "WomenFriendNames"
        case "Men (Friends)": key = "MenFriendNames"
        case "Jealous Ex (Woman)": key = "JealousExWomen"
        case "Jealous Ex (Man)": key = "JealousExMen"
        default: return
        }
        UserDefaults.standard.set(names, forKey: key)
    }

    private func resetToDefaults() {
        // Reset names based on category defaults
        names = NotificationData.getDefaultNames(for: category)
        saveNames()
    }
}
