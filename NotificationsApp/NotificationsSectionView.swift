//
//  NotificationsSectionView.swift
//  NotificationsApp
//
//  Created by Angelo Milonas on 4/20/25.
//

import SwiftUI

struct NotificationSection: Identifiable {
    var id: Int
    var isExpanded: Bool
    var startMinutes: Double = 1
    var endMinutes: Double = 15
    var selectedFromOption = "Mostly Women"
    var selectedSound = "iMessage"
    var selectedEmoji = "Off"
}

struct NotificationSectionView: View {
    @Binding var section: NotificationSection
        var onRemove: () -> Void
    
    let fromOptions = ["Women", "Men", "Mostly Women", "Mostly Men", "Jealous Ex (Woman)", "Jealous Ex (Man)"]
    let soundOptions = ["iMessage", "Tinder", "Instagram", "Snapchat", "Hinge"]
    let emojiOptions = ["Off", "Med", "High"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Notifications \(section.id + 1)")
                    .font(.system(size: 24, weight: .bold))
                Spacer()
                Button(section.isExpanded ? "Hide Details" : "Details") {
                    withAnimation {
                        section.isExpanded.toggle()
                    }
                }
                .font(.system(size: 16))
            }
            
            if section.isExpanded {
                VStack(alignment: .leading, spacing: 16) {
                    // Timer Slider
                    VStack(alignment: .leading) {
                        Text("Send every \(Int(section.startMinutes)) to \(Int(section.endMinutes)) minutes")
                            .font(.subheadline)
                        
                        DualSlider(
                            startValue: $section.startMinutes,
                            endValue: $section.endMinutes,
                            minimumValue: 1,
                            maximumValue: 30
                        )
                    }
                    
                    // From Dropdown
                    HStack {
                        Text("From")
                            .font(.subheadline)
                        Picker("From", selection: $section.selectedFromOption) {
                            ForEach(fromOptions, id: \.self) { option in
                                Text("\(emojiFor(option)) \(option)")
                                    .tag(option)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    Divider()
                    
                    // Sound Dropdown
                    HStack {
                        Text("Sound")
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
                    
                    // Emoji Radio Buttons
                    HStack {
                        Text("Emojis")
                            .font(.subheadline)
                        
                        HStack(spacing: 20) {
                            ForEach(emojiOptions, id: \.self) { emoji in
                                Button(action: {
                                    section.selectedEmoji = emoji
                                }) {
                                    HStack(spacing: 6) {
                                        Circle()
                                            .stroke(section.selectedEmoji == emoji ? Color.blue : Color.gray, lineWidth: 2)
                                            .frame(width: 20, height: 20)
                                            .overlay(
                                                Circle()
                                                    .fill(section.selectedEmoji == emoji ? Color.blue : Color.clear)
                                                    .frame(width: 10, height: 10)
                                            )
                                        
                                        Text(emoji)
                                            .foregroundColor(.primary)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle()) // Optional: prevents default button tint
                            }
                        }
                    }

                }
                Divider()
                Button("Remove Section") {
                    onRemove()
                }.foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
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
        case "Mostly Women": return "👯‍♀️"
        case "Mostly Men": return "👨‍👨‍👦‍👦"
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

