import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    @Published var isPlaying = false
    @Published var activeSections: [NotificationSection] = []
    
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
    
    func startNotifications(for sections: [NotificationSection]) {
        stopAllNotifications()
        activeSections = sections
        
        for section in sections {
            var baseTime = Date()
            
            for _ in 0..<section.quantity {
                let randomInterval = getRandomInterval(section: section)
                baseTime = baseTime.addingTimeInterval(randomInterval)
                let secondsFromNow = baseTime.timeIntervalSinceNow
                
                if secondsFromNow > 0 {
                    scheduleNotification(for: section, in: secondsFromNow)
                }
            }
        }
        
        isPlaying = true
    }
    
    func stopNotification(for id: Int) {
        timers[id]?.invalidate()
        timers.removeValue(forKey: id)
        activeSections.removeAll()

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
    
    private func scheduleNotification(for section: NotificationSection, in delay: TimeInterval) {
        let content = UNMutableNotificationContent()
        
        if section.selectedSound == "Tinder" {
            content.title = "Tinder"
            content.body = "You got a new match! 😍😍😍"
        } else {
            if section.selectedFromOption == "Group Chat" {
                let member = NotificationData.groupMemberNames.randomElement() ?? "Someone"
                let group = NotificationData.groupChatNames.randomElement() ?? "Group"
                content.title = "\(member) in \(group)"
            } else {
                let names = NotificationData.getNames(for: section.selectedFromOption)
                content.title = names.randomElement() ?? "Unknown"
            }
            
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
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        var remainingCount = section.quantity
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("⚠️ Notification error: \(error)")
            }
            
            DispatchQueue.main.async {
                remainingCount -= 1
                if remainingCount <= 0 {
                    if let index = NotificationManager.shared.activeSections.firstIndex(where: { $0.id == section.id }) {
                        NotificationManager.shared.activeSections[index].completed = true
                    }
                }
            }
        }
    }
}
