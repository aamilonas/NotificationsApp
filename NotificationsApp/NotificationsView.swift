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
        NotificationSection(id: 1, isExpanded: false)
    ]
    
    var body: some View {
        
        VStack {
            ZStack {
                // Black shadow layer (bottom)
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black)
                    .offset(x: 4, y: 4)
                    .frame(width: 353, height: 64)
                
                // Gray background layer (top)
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray5))
                    .frame(width: 353, height: 64)
                
                // Content: Text + Icon
                HStack(spacing: 8) {
                    Text("Fake Notifications ")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                    
                    Image(systemName: "bubble.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
            }
            .padding(.bottom, 10)
            
            NavigationView {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(notifications.indices, id: \.self) { index in
                            NotificationSectionView(
                                section: $notifications[index],
                                onRemove: {
                                    notifications.remove(at: index)
                                }
                            )
                            
                            if index < notifications.count - 1 {
                                Divider()
                                    .frame(height: 1)
                                    .background(Color.gray.opacity(0.3))
                            }
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
            }
        }
    }
}
