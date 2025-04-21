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
    var selectedFromOption = "Men"
    var selectedSound = "iMessage"
    var selectedIntensity = "Low"
}

struct NotificationSectionView: View {
    @Binding var section: NotificationSection
    
    let fromOptions = ["Men", "Women", "Mostly Men", "Mostly Women", "Jealous Ex"]
    let soundOptions = ["iMessage", "Tinder", "Instagram", "Snapchat", "Hinge"]
    let intensityOptions = ["Low", "Med", "High"]
    
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
                    VStack(alignment: .leading) {
                        Text("From")
                            .font(.subheadline)
                        Picker("From", selection: $section.selectedFromOption) {
                            ForEach(fromOptions, id: \.self) { option in
                                Text(option).tag(option)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    // Sound Dropdown
                    VStack(alignment: .leading) {
                        Text("Sound")
                            .font(.subheadline)
                        Picker("Sound", selection: $section.selectedSound) {
                            ForEach(soundOptions, id: \.self) { option in
                                HStack {
                                    Image(systemName: "music.note")
                                    Text(option)
                                }
                                .tag(option)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    // Intensity Radio Buttons
                    VStack(alignment: .leading) {
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
