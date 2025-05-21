import SwiftUI

@main
struct NotificationsAppApp: App {
    @StateObject private var subMgr = SubscriptionManager.shared
    init() {
        UIView.appearance().overrideUserInterfaceStyle = .dark
        UIView.appearance().tintColor = UIColor.systemPink
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(subMgr)
                //*environment(\.font, .custom("WorkSans", size:*/ 18)) // This line is fine if "WorkSans" exists, otherwise you'll need fallback too.
        }
    }
}
