//
//  JourneyApp.swift
//  Journey
//
//  Created by Шарап Бамматов on 14.11.2023.
//

import SwiftUI

@main
struct JourneyApp: App {
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LoginView()
                    .preferredColorScheme(.light)
            }
        }
    }
}
