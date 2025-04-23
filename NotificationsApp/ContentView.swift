import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var isPlaying = false
    @State private var player: AVAudioPlayer?

    var body: some View {
        ZStack(alignment: .bottom) {
            // Main screen
            NotificationsView()

            // Play/Stop toggle button
            Button(action: {
                withAnimation(.spring()) {
                    isPlaying.toggle()
                    playSound(named: isPlaying ? "play" : "stop")
                }
            }) {
                HStack {
                    Image(systemName: isPlaying ? "stop.fill" : "play.fill")
                        .foregroundColor(.white)
                    Text(isPlaying ? "STOP" : "Play")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .frame(width: 323, height: 48)
                .background(isPlaying ? Color.red : Color.green)
                .cornerRadius(24)
                .shadow(radius: 5)
            }
            .padding(.bottom, 30)
        }
        .ignoresSafeArea(edges: .bottom)
    }

    // Sound playback logic (optional)
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
