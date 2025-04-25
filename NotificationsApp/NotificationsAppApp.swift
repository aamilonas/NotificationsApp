//
//  NotificationsAppApp.swift
//  NotificationsApp
//
//  Created by Angelo Milonas on 4/20/25.
//

import SwiftUI

@main
struct NotificationsAppApp: App {
    //forces light mode
    
    init() {
        UIView.appearance().overrideUserInterfaceStyle = .light
        // Register fonts
        if let fontURL = Bundle.main.url(forResource: "YourFontName", withExtension: "otf") {
            CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, nil)
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.font, .custom("WorkSans", size: 18))
        }
    }
}
