import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    @Published var isPlaying = false
    private var timers: [Int: Timer] = [:]

    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("✅ Notification permission granted")
            } else if let error = error {
                print("❌ Error requesting notification permission: \(error)")
            } else {
                print("❌ Notification permission denied")
            }
        }

        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("🔍 Notification status: \(settings.authorizationStatus.rawValue)")
        }
    }

    func startNotifications(for section: NotificationSection) {
        stopNotification(for: section.id)
        scheduleNextNotification(for: section)
    }

    private func scheduleNextNotification(for section: NotificationSection) {
        let randomInterval = getRandomInterval(section: section)

        let timer = Timer.scheduledTimer(withTimeInterval: randomInterval, repeats: false) { [weak self] _ in
            guard let self = self else { return }

            self.scheduleNotification(for: section) // 🔥 Send the notification
            self.scheduleNextNotification(for: section) // 🔥 Schedule next random notification
        }

        RunLoop.main.add(timer, forMode: .common)
        timers[section.id] = timer

        print("📩 [DEBUG] Scheduled notification for section \(section.id) in \(String(format: "%.1f", randomInterval)) seconds")
    }

    func stopNotification(for id: Int) {
        timers[id]?.invalidate()
        timers.removeValue(forKey: id)
    }

    func stopAllNotifications() {
        timers.values.forEach { $0.invalidate() }
        timers.removeAll()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    private func getRandomInterval(section: NotificationSection) -> TimeInterval {
        let minSeconds = max(1, section.startMinutes * 60)
        let maxSeconds = max(minSeconds + 1, section.endMinutes * 60)
        return TimeInterval.random(in: minSeconds...maxSeconds)
    }

    private func scheduleNotification(for section: NotificationSection) {
        let content = UNMutableNotificationContent()

        if section.selectedSound == "Tinder" {
            content.title = "Tinder"
            content.body = "You got a new match! 😍😍😍"
        } else {
            let names = NotificationData.getNames(for: section.selectedFromOption)
            content.title = names.randomElement() ?? "Unknown"
            content.body = NotificationData.getMessage(for: section.selectedFromOption, emojiLevel: section.selectedEmoji)
        }

        switch section.selectedSound {
        case "iMessage":
            content.sound = UNNotificationSound(named: UNNotificationSoundName("iMessage.wav"))
        case "Tinder":
            content.sound = UNNotificationSound(named: UNNotificationSoundName("Tinder.wav"))
        case "Instagram":
            content.sound = UNNotificationSound(named: UNNotificationSoundName("Instagram.wav"))
        case "Snapchat":
            content.sound = UNNotificationSound(named: UNNotificationSoundName("Snapchat.wav"))
        default:
            content.sound = .default
        }

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("⚠️ Notification error: \(error)")
            }
        }
    }
}
