//
//  InstantNewsApp.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import SwiftUI

final class AppState : ObservableObject {
    @Published var rootViewId = UUID()
}

@main
struct InstantNewsApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
