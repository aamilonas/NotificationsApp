import SwiftUI
import AVFoundation

struct ContentView: View {
    
    // Subscription state
    @EnvironmentObject private var subMgr: SubscriptionManager
    @State private var showPaywall = false

    // Notification state
    @StateObject private var notificationManager = NotificationManager.shared
    @State private var player: AVAudioPlayer?
    @State private var notifications: [NotificationSection] = [
        NotificationSection(id: 0, isExpanded: true),
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            // Main notifications UI
            NotificationsView(
                notifications: $notifications,
                isPlaying: notificationManager.isPlaying
            )

            // Play / Stop button
            Button {
                if notificationManager.isPlaying {
                    // Currently running → always stop, no popup
                    toggleAndSchedule()
                } else {
                    // Currently stopped → about to play
                    if !subMgr.isSubscribed {
                        showPaywall = true
                    } else {
                        toggleAndSchedule()
                    }
                }
            } label: {
                HStack {
                    Image(systemName: notificationManager.isPlaying ? "stop.fill" : "play.fill")
                        .foregroundColor(.white)
                    Text(notificationManager.isPlaying ? "STOP" : "Play")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .frame(width: 323, height: 48)
                .background(notificationManager.isPlaying ? Color.red : Color.green)
                .cornerRadius(24)
                .shadow(radius: 5)
            }
            .padding(.bottom, 30)
        }
        .ignoresSafeArea(edges: .bottom)

        // Paywall alert on Play
        .alert("You are using the notifAI free version!",
               isPresented: $showPaywall) {
            Button("Subscribe (3.99$)") {
                Task {
                    try? await subMgr.purchase()
                }
            }
            Button("Continue") {
                // 1) Cap every section to 5 notifications
                for idx in notifications.indices {
                    notifications[idx].quantity = 5
                }
                // 2) Now actually start
                toggleAndSchedule()
            }
        } message: {
            Text("""
                 A maximum of 5 notifications a day can be set. \
                 Subscribe now for unlimited notifications & all notification sounds.
                 """)
        }
    }

    // MARK: – Playback & scheduling

    private func toggleAndSchedule() {
        withAnimation(.spring()) {
            notificationManager.isPlaying.toggle()
            playSound(named: notificationManager.isPlaying ? "start" : "stop")

            if notificationManager.isPlaying {
                notificationManager.startNotifications(for: notifications)
            } else {
                notificationManager.stopAllNotifications()
            }
        }
    }

    private func playSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("🔊 Sound file not found: \(name).mp3")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("🔊 Error playing sound: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SubscriptionManager.shared)
}
