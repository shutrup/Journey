//
//  RegistrationView.swift
//  Journey
//
//  Created by Шарап Бамматов on 14.11.2023.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = AuthViewModel(userDataService: UserDataService.userDataService)
    @EnvironmentObject var store: Store
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image("previewImage")
                .resizable()
                .padding(-5)
                .blur(radius: 3)
            
            VStack(spacing: 13) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundStyle(.white)
                        .bold()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                
                JourneyTitleView()
                
                Text("Регистрация")
                    .font(.rubikRegular(size: 24))
                    .foregroundColor(.white)
                    .padding(.top)
                
                VStack(spacing: 8) {
                    RoundedTextField(placeholder: "Почта", text: $viewModel.email, imageName: viewModel.isEmailValid ? "checkmark" : "", isSecure: false, imageColor: .green)
                    
                    RoundedTextField(placeholder: "Имя", text: $viewModel.name, isSecure: false, imageColor: .green)
                    
                    RoundedTextField(placeholder: "Пароль", text: $viewModel.password, isSecure: true, imageColor: .secondary)
                    
                    RoundedTextField(placeholder: "Подвердите пароль", text: $viewModel.confirmPassword, isSecure: true, imageColor: .secondary)
                }
                
                Button {
                    Task {
                        await viewModel.registration()
                    }
                } label: {
                    Text("Создать")
                        .font(.rubikRegular(size: 14))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 0)
                        .padding(.vertical, 17)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 51, alignment: .center)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.31, green: 0.9, blue: 0.55).opacity(0.95), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.11, green: 0.78, blue: 0.48).opacity(0.95), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0, y: 0.51),
                                endPoint: UnitPoint(x: 1, y: 0.51)
                            )
                        )
                        .cornerRadius(16)
                }
                .padding(.top)
                
                Spacer()
                
                GoogleAndFacebookButtons(googleAction: {}, facebookAction: {})
            }
            .padding(.top, 50)
            .padding(.vertical)
        }
        .edgesIgnoringSafeArea(.bottom)
        .ignoresSafeArea()
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onChange(of: viewModel.authStatus) { oldValue, newValue in
            if newValue == .loaded {
                dismiss()
                
                withAnimation {
                    store.showLogInScreen = false
                }
            }
        }
    }
}

#Preview {
    RegistrationView()
        .environmentObject(Store())
}
