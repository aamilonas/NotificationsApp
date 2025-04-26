import SwiftUI

struct NotificationSection: Identifiable {
    var id: Int
    var isExpanded: Bool
    var startMinutes: Double = 0
    var endMinutes: Double = 15
    var selectedFromOption = "Women"
    var selectedSound = "iMessage"
    var selectedEmoji = "Off"
}

struct NotificationSectionView: View {
    @Binding var section: NotificationSection
    var isDisabled: Bool
    var onRemove: () -> Void

    @State private var showingSettings = false

    let fromOptions = ["Women", "Men", "Women (Friends)", "Men (Friends)", "Jealous Ex (Woman)", "Jealous Ex (Man)"]
    let soundOptions = ["iMessage", "Tinder", "Instagram", "Snapchat"]
    let emojiOptions = ["Off", "Med", "High"]

    var body: some View {
        let _ = {
            if isDisabled && section.isExpanded {
                section.isExpanded = false
            }
        }()

        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Notifications \(section.id + 1)")
                    .font(.system(size: 24, weight: .bold))

                if isDisabled {
                    Text("Running")
                        .font(.subheadline)
                        .foregroundColor(.green)
                        .padding(.leading, 8)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.3), value: isDisabled)
                }

                Spacer()

                Button(section.isExpanded ? "Hide Details" : "Details") {
                    withAnimation {
                        section.isExpanded.toggle()
                    }
                }
                .font(.system(size: 16))
            }
            .disabled(isDisabled)
            .opacity(isDisabled ? 0.5 : 1.0)

            if section.isExpanded {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading) {
                            Text("Send every \(Int(section.startMinutes)) to \(Int(section.endMinutes)) minutes")
                                .font(.subheadline)

                            DualSlider(
                                startValue: $section.startMinutes,
                                endValue: $section.endMinutes,
                                minimumValue: 0,
                                maximumValue: 45
                            )
                        }

                        HStack {
                            Text("From:")
                                .font(.subheadline)

                            Picker("From", selection: $section.selectedFromOption) {
                                ForEach(fromOptions, id: \.self) { option in
                                    Text("\(emojiFor(option)) \(option)")
                                        .tag(option)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())

                            Spacer()

                            Button(action: {
                                showingSettings = true
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "gear")
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                    Text("Edit")
                                        .font(.footnote)
                                        .foregroundColor(.pink)
                                }
                            }
                        }
                        .sheet(isPresented: $showingSettings) {
                            SettingsView(category: section.selectedFromOption)
                        }
                    }

                    Divider()

                    HStack {
                        Text("Sound:")
                            .font(.subheadline)
                        Picker("Sound", selection: $section.selectedSound) {
                            ForEach(soundOptions, id: \.self) { option in
                                Text("\(emojiForSound(option)) \(option)")
                                    .tag(option)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }

                    Divider()

                    // ➡️ EMOJIS
                    HStack {
                        Text("Emojis:")
                            .font(.subheadline)
Spacer()
                        HStack(spacing: 20) {
                            ForEach(emojiOptions, id: \.self) { emoji in
                                Button(action: {
                                    section.selectedEmoji = emoji
                                }) {
                                    HStack(spacing: 6) {
                                        Circle()
                                            .stroke(section.selectedEmoji == emoji ? Color.pink : Color.gray, lineWidth: 2)
                                            .frame(width: 20, height: 20)
                                            .overlay(
                                                Circle()
                                                    .fill(section.selectedEmoji == emoji ? Color.pink : Color.clear)
                                                    .frame(width: 10, height: 10)
                                            )
                                        Text(emoji)
                                            .foregroundColor(.primary)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                        Spacer()
                    }


                    Divider()

                    Button("Remove Section") {
                        onRemove()
                    }
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .disabled(isDisabled)
                .opacity(isDisabled ? 0.5 : 1.0)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }

    private func emojiFor(_ option: String) -> String {
        switch option {
        case "Women": return "👩"
        case "Men": return "👨"
        case "Women (Friends)": return "🙋‍♀️"
        case "Men (Friends)": return "🙋‍♂️"
        case "Jealous Ex (Woman)": return "👿"
        case "Jealous Ex (Man)": return "👿"
        default: return ""
        }
    }

    private func emojiForSound(_ option: String) -> String {
        switch option {
        case "iMessage": return "💬"
        case "Tinder": return "❣️"
        case "Instagram": return "📸"
        case "Snapchat": return "👻"
        case "Hinge": return "☁️"
        default: return ""
        }
    }
}
