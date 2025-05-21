// NotificationManager.swift

import Foundation
import UserNotifications

@MainActor
class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    @Published var isPlaying = false

    // MARK: – Free tier limit
    private let maxPerDay = 5
    private var sentTimestamps: [Date] {
        get { (UserDefaults.standard.array(forKey: "sentTimestamps") as? [Date]) ?? [] }
        set { UserDefaults.standard.set(newValue, forKey: "sentTimestamps") }
    }

    
    private func canScheduleAnother() -> Bool {
        // Subscribed users bypass the limit
        if SubscriptionManager.shared.isSubscribed {
            return true
        }
        let cutoff = Date().addingTimeInterval(-24 * 60 * 60)
        let recent = sentTimestamps.filter { $0 > cutoff }
        return recent.count < maxPerDay
    }

    private func recordSend() {
        let cutoff = Date().addingTimeInterval(-24 * 60 * 60)
        var recent = sentTimestamps.filter { $0 > cutoff }
        recent.append(Date())
        sentTimestamps = recent
    }

    // MARK: – Notification state
    private var timers: [Int: Timer] = [:]
    @Published var activeSections: [NotificationSection] = []

    private init() {
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

    // MARK: – Start / Stop

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
        if let idx = activeSections.firstIndex(where: { $0.id == id }) {
            activeSections[idx].completed = true
        }
    }

    func stopAllNotifications() {
        timers.values.forEach { $0.invalidate() }
        timers.removeAll()
        activeSections.removeAll()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    // MARK: – Scheduling

    private func scheduleNotification(for section: NotificationSection, after delay: TimeInterval, index: Int) {
        guard canScheduleAnother() else {
            print("🔒 Daily limit reached — skipping notification \(index) for section \(section.id)")
            return
        }
        recordSend()

        let content = UNMutableNotificationContent()
        // Title & body selection
        if section.selectedSound == "LoveMatch" {
            content.title = "LoveMatch"
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

        // Sound selection
        switch section.selectedSound {
        case "MessagePop":
            content.sound = UNNotificationSound(named: .init("iMessage.wav"))
        case "LoveMatch":
            content.sound = UNNotificationSound(named: .init("Tinder.wav"))
        case "GramPing":
            content.sound = UNNotificationSound(named: .init("Instagram.wav"))
        case "SnapTone":
            content.sound = UNNotificationSound(named: .init("Snapchat.wav"))
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
                let fire = Date().addingTimeInterval(delay)
                let fmt = DateFormatter()
                fmt.dateStyle = .none; fmt.timeStyle = .medium
                print("📩 Scheduled #\(index) for section \(section.id) at \(fmt.string(from: fire))")
            }
        }
    }

    // Fallback single-fire scheduler (if used elsewhere)
    private func scheduleNotification(for section: NotificationSection) {
        guard canScheduleAnother() else {
            print("🔒 Daily limit reached — skipping immediate notification")
            return
        }
        recordSend()

        let content = UNMutableNotificationContent()
        if section.selectedSound == "LoveMatch" {
            content.title = "LoveMatch"
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
        case "MessagePop":
            content.sound = UNNotificationSound(named: .init("iMessage.wav"))
        case "LoveMatch":
            content.sound = UNNotificationSound(named: .init("Tinder.wav"))
        case "GramPing":
            content.sound = UNNotificationSound(named: .init("Instagram.wav"))
        case "SnapTone":
            content.sound = UNNotificationSound(named: .init("Snapchat.wav"))
        default:
            content.sound = .default
        }

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        )
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("⚠️ Notification error: \(error)")
            }
        }
    }
}
