// NotificationManager.swift
import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    @Published var isPlaying = false

    private var timers: [Int: Timer] = [:]
    @Published var activeSections: [NotificationSection] = []

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

    func startNotifications(for sections: [NotificationSection]) {
        stopAllNotifications()
        isPlaying = true
        activeSections = []

        for section in sections {
            var copy = section
            copy.notificationsRemaining = section.quantity
            activeSections.append(copy)

            var cumulativeDelay: TimeInterval = 0

            for i in 1...copy.quantity {
                let interval = TimeInterval.random(in: copy.startMinutes * 60 ... copy.endMinutes * 60)
                cumulativeDelay += interval
                scheduleNotification(for: copy, after: cumulativeDelay, index: i)
            }
        }
    }



    func stopNotification(for id: Int) {
        timers[id]?.invalidate()
        timers.removeValue(forKey: id)

        if let index = activeSections.firstIndex(where: { $0.id == id }) {
            activeSections[index].completed = true
        }
    }

    func stopAllNotifications() {
        timers.values.forEach { $0.invalidate() }
        timers.removeAll()
        activeSections.removeAll()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    private func getRandomInterval(section: NotificationSection) -> TimeInterval {
        let minSeconds = max(1, section.startMinutes * 60)
        let maxSeconds = max(minSeconds + 1, section.endMinutes * 60)
        return TimeInterval.random(in: minSeconds...maxSeconds)
    }

    private func scheduleNotification(for section: NotificationSection, after delay: TimeInterval, index: Int) {
        let content = UNMutableNotificationContent()

        if section.selectedSound == "Tinder" {
            content.title = "Tinder"
            content.body = "You got a new match! 😍😍😍"
        } else if section.selectedFromOption == "Group Chat" {
            let member = NotificationData.groupMemberNames.randomElement() ?? "Someone"
            let group = NotificationData.groupChatNames.randomElement() ?? "Group"
            content.title = "\(member) in \(group)"
            content.body = NotificationData.getMessage(for: section.selectedFromOption)
        } else {
            let names = NotificationData.getNames(for: section.selectedFromOption)
            content.title = names.randomElement() ?? "Unknown"
            content.body = NotificationData.getMessage(for: section.selectedFromOption)
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

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
        let identifier = "section\(section.id)_notif\(index)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("⚠️ Notification error: \(error)")
            } else {
                let fireTime = Date().addingTimeInterval(delay)
                let formatter = DateFormatter()
                formatter.timeStyle = .medium
                formatter.dateStyle = .none
                print("📩 [DEBUG] Scheduled notification \(index) for section \(section.id) at \(formatter.string(from: fireTime))")
            }
        }
    }



    private func scheduleNotification(for section: NotificationSection) {
        let content = UNMutableNotificationContent()

        if section.selectedSound == "Tinder" {
            content.title = "Tinder"
            content.body = "You got a new match! 😍😍😍"
        } else if section.selectedFromOption == "Group Chat" {
            let member = NotificationData.groupMemberNames.randomElement() ?? "Someone"
            let group = NotificationData.groupChatNames.randomElement() ?? "Group"
            content.title = "\(member) in \(group)"
            content.body = NotificationData.getMessage(for: section.selectedFromOption)
        } else {
            let names = NotificationData.getNames(for: section.selectedFromOption)
            content.title = names.randomElement() ?? "Unknown"
            content.body = NotificationData.getMessage(for: section.selectedFromOption)
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

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("⚠️ Notification error: \(error)")
            }
        }
    }
}
