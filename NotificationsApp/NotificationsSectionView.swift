import SwiftUI

struct NotificationSection: Identifiable {
    var id: Int
    var isExpanded: Bool
    var startMinutes: Double = 0
    var endMinutes: Double = 15
    var selectedFromOption = "Women"
    var selectedSound = "MessagePop"
    var quantity: Int = 10
    var completed: Bool = false
    var notificationsRemaining: Int = 0

}

import SwiftUI

struct NotificationSectionView: View {
    @Binding var section: NotificationSection
    var isDisabled: Bool
    var onRemove: () -> Void

    @EnvironmentObject private var subMgr: SubscriptionManager
    @State private var showingSettings = false

    // to manage paywall when selecting premium sounds
    @State private var showSoundPaywall = false
    @State private var pendingSoundSelection: String = ""

    let fromOptions = ["Women", "Men", "Women (Friends)", "Men (Friends)", "Jealous Ex", "Group Chat"]
    let allSounds = ["MessagePop", "LoveMatch", "GramPing", "SnapTone"]

    var body: some View {
        // collapse if disabled
        let _ = {
            if isDisabled && section.isExpanded {
                section.isExpanded = false
            }
        }()

        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Text("Notifications \(section.id + 1)")
                    .font(.system(size: 24, weight: .bold))

                if isDisabled {
                    let label = section.completed ? "Finished" : "Running"
                    Text(label)
                        .font(.subheadline)
                        .foregroundColor(section.completed ? .yellow : .green)
                        .padding(.leading, 8)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.3), value: isDisabled)
                }

                Spacer()

                Button(section.isExpanded ? "Hide Details" : "Details") {
                    withAnimation { section.isExpanded.toggle() }
                }
                .font(.system(size: 16))
            }
            .disabled(isDisabled)
            .opacity(isDisabled ? 0.5 : 1.0)

            // Details
            if section.isExpanded {
                VStack(alignment: .leading, spacing: 16) {
                    // Timing & From
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Send every \(Int(section.startMinutes)) to \(Int(section.endMinutes)) minutes")
                            .font(.subheadline)

                        DualSlider(
                            startValue: $section.startMinutes,
                            endValue: $section.endMinutes,
                            minimumValue: 0,
                            maximumValue: 45
                        )

                        HStack {
                            Text("From:")
                                .font(.subheadline)

                            Picker("From", selection: $section.selectedFromOption) {
                                ForEach(fromOptions, id: \.self) { option in
                                    Text("\(emojiFor(option)) \(option)").tag(option)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())

                            Spacer()

                            Button {
                                showingSettings = true
                            } label: {
                                HStack(spacing: 4) {
                                    Image(systemName: "gear").frame(width: 16, height: 16)
                                    Text("Edit").font(.footnote).foregroundColor(.pink)
                                }
                            }
                            .sheet(isPresented: $showingSettings) {
                                SettingsView(category: section.selectedFromOption)
                            }
                        }
                    }

                    Divider()

                    // Sound picker with paywall intercept
                    HStack {
                        Text("Sound:")
                            .font(.subheadline)

                        Picker("Sound", selection: Binding(
                            get: { section.selectedSound },
                            set: { newValue in
                                // if free user and not MessagePop, intercept
                                if !subMgr.isSubscribed && newValue != "MessagePop" {
                                    pendingSoundSelection = newValue
                                    showSoundPaywall = true
                                } else {
                                    section.selectedSound = newValue
                                }
                            }
                        )) {
                            ForEach(allSounds, id: \.self) { option in
                                Text("\(emojiForSound(option)) \(option)")
                                    .tag(option)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }

                    Divider()

                    // Quantity
                    HStack {
                        Text("Number of Notifications:")
                            .font(.subheadline)
                        Spacer()
                        Picker("Quantity", selection: $section.quantity) {
                            ForEach(1..<51) { number in
                                Text("\(number)").tag(number)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 100, height: 80)
                    }

                    Divider()

                    Button("Remove Section", action: onRemove)
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
        // Sound paywall alert
        .alert("You are using the free version of NotifAI",
               isPresented: $showSoundPaywall) {
            Button("Subscribe") {
                Task {
                    try? await subMgr.purchase()
                    // once subscribed, allow the pending choice
                    section.selectedSound = pendingSoundSelection
                }
            }
            Button("Continue") {
                // revert to MessagePop
                section.selectedSound = "MessagePop"
            }
        } message: {
            Text("Subscribe now to access other sounds like LoveMatch, GramPing, and SnapTone!")
        }
    }

    // Emoji helpers
    private func emojiFor(_ option: String) -> String {
        switch option {
        case "Women": return "👩"
        case "Men": return "👨"
        case "Women (Friends)": return "🙋‍♀️"
        case "Men (Friends)": return "🙋‍♂️"
        case "Jealous Ex": return "👿"
        case "Group Chat": return "❇️"
        default: return ""
        }
    }

    private func emojiForSound(_ option: String) -> String {
        switch option {
        case "MessagePop": return "💬"
        case "LoveMatch": return "❣️"
        case "GramPing": return "📸"
        case "SnapTone": return "👻"
        default: return ""
        }
    }
}
