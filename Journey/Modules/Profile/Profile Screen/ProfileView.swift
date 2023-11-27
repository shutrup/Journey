//
//  ProfileView.swift
//  Journey
//
//  Created by Шарап Бамматов on 23.11.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var store: Store
    @State var showFavorite: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(.avatar)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding(.top, 20)
                
                Text("Shurup")
                    .font(.ptSansBold(size: 24))
                
                VStack(spacing: 30) {
                    ProfileRowView(image: "star", title: "Избранные", action: {
                        showFavorite.toggle()
                    })
                    ProfileRowView(image: "phone", title: "Свяжитесь с нами", action: {})
                    ProfileRowView(image: "lock", title: "Политика конфиденциальности", action: {})
                    ProfileRowView(image: "arrow.right.to.line", title: "Выход", action: {
                        withAnimation {
                            store.showLogInScreen = true
                        }
                    })
                }
                .padding(.top, 40)
                
                Spacer()
            }
        }
        .navigationTitle("Профиль")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showFavorite) {
            FavoriteView(show: $showFavorite)
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environmentObject(Store())
    }
}
