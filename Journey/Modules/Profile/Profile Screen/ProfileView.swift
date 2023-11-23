//
//  ProfileView.swift
//  Journey
//
//  Created by Шарап Бамматов on 23.11.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        Button {
            withAnimation {
                store.showLogInScreen = true
            }
        } label: {
            Text("Выход")
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    ProfileView()
        .environmentObject(Store())
}
