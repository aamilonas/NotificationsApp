import SwiftUI

struct NotificationsView: View {
    @Binding var notifications: [NotificationSection]
    var isPlaying: Bool

    @StateObject private var notificationManager = NotificationManager.shared

    var body: some View {
        ZStack(alignment: .top) {
            // 🔹 Top banner background
            Color(red: 14/255, green: 15/255, blue: 14/255)
                .frame(height: 150)
                .ignoresSafeArea(edges: .top)

            // 🔹 Logo
            VStack {
                if let uiImage = UIImage(named: "notifai_red") {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 230)
                        .padding(.top, -45)
                } else {
                    Text("NotifAI")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.pink)
                        .padding(.top, 40)
                }

                
                Spacer()
            }

            // 🔹 Scrollable Notifications with correct top and bottom fade
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 85)

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(notifications.indices, id: \.self) { index in
                            NotificationSectionView(
                                section: $notifications[index],
                                isDisabled: notificationManager.isPlaying,
                                onRemove: {
                                    let removedID = notifications[index].id
                                    NotificationManager.shared.stopNotification(for: removedID)
                                    notifications.remove(at: index)
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
                                .foregroundColor(.pink)
                        }
                        .padding()
                    }
                    .padding(.top, 10)
                    .padding(.horizontal)
                    .padding(.bottom, 100) // ➔ Space for Play button
                }
                .mask(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .clear, location: 0),
                            .init(color: .black, location: 0.05),
                            .init(color: .black, location: 0.85), // 🛠️ Fades out earlier (before Play button)
                            .init(color: .clear, location: 1)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .onDisappear {
                notificationManager.stopAllNotifications()
                notificationManager.isPlaying = false
            }
        }
    }
}
