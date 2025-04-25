// ✅ NotificationManager.swift
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

        // Schedule the first notification shortly after starting
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.scheduleNotification(for: section)
        }

        // Start a repeating timer
        let timer = Timer.scheduledTimer(withTimeInterval: getRandomInterval(section: section), repeats: true) { [weak self] _ in
            self?.scheduleNotification(for: section)
        }

        RunLoop.main.add(timer, forMode: .common)

        // ✅ Store the timer to allow stopping it
        self.timers[section.id] = timer
    }



    func stopNotification(for id: Int) {
        timers[id]?.invalidate()
        timers.removeValue(forKey: id)
    }

    private func getRandomInterval(section: NotificationSection) -> TimeInterval {
        let min = max(1, section.startMinutes * 60)
        let max = max(min + 1, section.endMinutes * 60)
        return TimeInterval.random(in: min...max)
    }


    func stopAllNotifications() {
        timers.values.forEach { $0.invalidate() }
        timers.removeAll()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
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

        // Sound
        switch section.selectedSound {
        case "iMessage": content.sound = UNNotificationSound(named: UNNotificationSoundName("iMessage.wav"))
        case "Tinder": content.sound = UNNotificationSound(named: UNNotificationSoundName("Tinder.wav"))
        case "Instagram": content.sound = UNNotificationSound(named: UNNotificationSoundName("Instagram.wav"))
        case "Snapchat": content.sound = UNNotificationSound(named: UNNotificationSoundName("Snapchat.wav"))
        default: content.sound = .default
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
