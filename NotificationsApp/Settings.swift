//
//  Settings.swift
//  NotificationsApp
//
//  Created by Angelo Milonas on 4/24/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("womenNames") var womenNamesString: String = "Emma,Olivia,Sophia"
    @AppStorage("menNames") var menNamesString: String = "Liam,Noah,Oliver"

    var body: some View {
        Form {
            Section(header: Text("Women Names")) {
                TextEditor(text: $womenNamesString)
                    .frame(height: 100)
            }

            Section(header: Text("Men Names")) {
                TextEditor(text: $menNamesString)
                    .frame(height: 100)
            }
        }
        .navigationTitle("Settings")
    }
}

