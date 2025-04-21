//
//  ContentView.swift
//  NotificationsApp
//
//  Created by Angelo Milonas on 4/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NotificationsView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Menu")
                }
                .tag(0)
            
            ChatView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Chat")
                }
                .tag(1)
        }
    }
}

#Preview {
    ContentView()
}
