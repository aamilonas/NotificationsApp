//
//  NotificationsView.swift
//  NotificationsApp
//
//  Created by Angelo Milonas on 4/20/25.
//

import SwiftUI

struct NotificationsView: View {
    @State private var notifications: [NotificationSection] = [
        NotificationSection(id: 0, isExpanded: true),
        NotificationSection(id: 1, isExpanded: true)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach($notifications) { $section in
                        NotificationSectionView(section: $section)
                    }
                    
                    Button(action: {
                        notifications.append(NotificationSection(id: notifications.count, isExpanded: true))
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 44))
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
                .padding()
            }
            .navigationTitle("Fake Notifications").font(.title)
        }
    }
}
