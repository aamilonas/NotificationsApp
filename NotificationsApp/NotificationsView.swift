import SwiftUI

struct NotificationsView: View {
    @Binding var notifications: [NotificationSection]
    var isPlaying: Bool

    @StateObject private var notificationManager = NotificationManager.shared

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black)
                    .offset(x: 4, y: 4)
                    .frame(width: 353, height: 64)

                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray5))
                    .frame(width: 353, height: 64)

                HStack(spacing: 8) {
                    Text("Fake Notifications")
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

            ScrollView {
                VStack(spacing: 20) {
                    ForEach(notifications.indices, id: \.self) { index in
                        NotificationSectionView(
                            section: $notifications[index],
                            isDisabled: notificationManager.isPlaying,
                            onRemove: {
                                let removedID = notifications[index].id
                                NotificationManager.shared.stopNotification(for: removedID) // 🛑 stop this timer
                                notifications.remove(at: index)

                                // Reassign IDs to maintain consistency
                                for i in 0..<notifications.count {
                                    notifications[i].id = i
                                }
                            }
                        )

                        if index < notifications.count - 1 {
                            Divider()
                                .frame(height: 1)
                                .background(Color.gray.opacity(0.3))
                        }
                    }

                    Button(action: {
                        let newID = notifications.count
                        notifications.append(NotificationSection(id: newID, isExpanded: true))
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 44))
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
                .padding()
                .padding(.bottom, 100)
            }
        }
        .onDisappear {
            notificationManager.stopAllNotifications()
            notificationManager.isPlaying = false
        }
    }
}

