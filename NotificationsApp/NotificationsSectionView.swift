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
    var selectedFromOption = "Women"
    var selectedSound = "iMessage"
    var selectedIntensity = "Off"
}



struct NotificationSectionView: View {
    @Binding var section: NotificationSection
    
    let fromOptions = ["Women", "Men", "Mostly Women", "Mostly Men",   "Jealous Ex (Woman)", "Jealous Ex (Man)"]
    let soundOptions = ["iMessage", "Tinder", "Instagram", "Snapchat", "Hinge"]
    let intensityOptions = ["Off", "Low", "High"]
    
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
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray.opacity(0.1))

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
                        .frame(height: 1)
                        .background(Color.gray.opacity(0.1))

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
                        .frame(height: 1)
                        .background(Color.gray.opacity(0.1))

                    // Intensity Radio Buttons
                    HStack() {
                        Text("Intensity")
                            .font(.subheadline)
                        HStack(spacing: 20) {
                            ForEach(intensityOptions, id: \.self) { intensity in
                                Button(action: {
                                    section.selectedIntensity = intensity
                                }) {
                                    HStack {
                                        Image(systemName: section.selectedIntensity == intensity ? "largecircle.fill.circle" : "circle")
                                            .foregroundColor(section.selectedIntensity == intensity ? .blue : .gray)
                                        Text(intensity)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}


func emojiFor(_ option: String) -> String {
    switch option {
    case "Men":
        return "🙎‍♂️"
    case "Women":
        return "🙎‍♀️"
    case "Mostly Men":
        return "👬"
    case "Mostly Women":
        return "👯‍♀️"
    case "Jealous Ex (Woman)":
        return "❤️‍🔥"
    case "Jealous Ex (Man)":
            return "🫀"
    default:
        return "❓"
    }
}

func emojiForSound(_ option: String) -> String {
    switch option {
    case "iMessage": return "💬"
    case "Tinder": return "❣️"
    case "Instagram": return "🌄"
    case "Snapchat": return "👻"
    case "Hinge": return "☁️"
    default: return "🎵"
    }
}

