import SwiftUI

@main
struct NotificationsAppApp: App {
    init() {
        UIView.appearance().overrideUserInterfaceStyle = .dark
        UIView.appearance().tintColor = UIColor.systemPink
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                //*environment(\.font, .custom("WorkSans", size:*/ 18)) // This line is fine if "WorkSans" exists, otherwise you'll need fallback too.
        }
    }
}
