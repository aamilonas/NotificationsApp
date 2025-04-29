import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var notificationManager = NotificationManager.shared
    @State private var player: AVAudioPlayer?
    @State private var notifications: [NotificationSection] = [
        NotificationSection(id: 0, isExpanded: true),
        //NotificationSection(id: 1, isExpanded: false)
    ]

    var body: some View {
        
        ZStack(alignment: .bottom) {
            // Main screen
            NotificationsView(notifications: $notifications, isPlaying: notificationManager.isPlaying)

            // Play/Stop toggle button
            Button(action: {
                withAnimation(.spring()) {
                    notificationManager.isPlaying.toggle()
                    playSound(named: notificationManager.isPlaying ? "start" : "stop")

                    
                    if notificationManager.isPlaying {
                        notificationManager.startNotifications(for: notifications)
                    } else {
                        notificationManager.stopAllNotifications()
                    }

                }
            }) {
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
    }

    // Sound playback logic
    func playSound(named name: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
}
