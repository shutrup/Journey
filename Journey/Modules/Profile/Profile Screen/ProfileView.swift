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
    @StateObject var viewModel = AuthViewModel(userDataService: UserDataService.userDataService)
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(.avatar)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding(.top, 20)
                    .overlay(alignment: .bottomTrailing) {
                        Button {
                            
                        } label: {
                            Circle()
                                .fill(.white)
                                .frame(width: 50, height: 50)
                                .overlay {
                                    Circle()
                                        .fill(Color.tab)
                                        .frame(width: 40, height: 40)
                                        .overlay {
                                            Image(systemName: "pencil")
                                                .imageScale(.large)
                                                .foregroundStyle(.white)
                                                .bold()
                                        }
                                }
                        }
                    }
                
                Text(viewModel.user?.name ?? "UserName")
                    .font(.ptSansBold(size: 20))
                
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
            .navigationDestination(isPresented: $showFavorite) {
                FavoriteView(show: $showFavorite)
            }
            .task {
                await viewModel.fetchUser(id: store.userId)
            }
        }
        .navigationTitle("Профиль")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environmentObject(Store())
    }
}
