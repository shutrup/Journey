//
//  RegistrationView.swift
//  Journey
//
//  Created by Шарап Бамматов on 14.11.2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = String()
    @State private var name = String()
    @State private var password = String()
    @State private var confirmPassword = String()
    @Environment(\.dismiss) var dismiss
    
    var isEmailValid: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
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
                    .font(.regular(size: 24))
                    .foregroundColor(.white)
                    .padding(.top)
                
                VStack(spacing: 8) {
                    RoundedTextField(placeholder: "Почта", text: $email, imageName: isEmailValid ? "checkmark" : "", isSecure: false, imageColor: .green)
                    
                    RoundedTextField(placeholder: "Имя", text: $name, imageName: isEmailValid ? "checkmark" : "", isSecure: false, imageColor: .green)
                    
                    RoundedTextField(placeholder: "Пароль", text: $password, imageName: isEmailValid ? "checkmark" : "", isSecure: true, imageColor: .secondary)
                    
                    RoundedTextField(placeholder: "Подвердите пароль", text: $confirmPassword, imageName: isEmailValid ? "checkmark" : "",  isSecure: true, imageColor: .secondary)
                }
                
                Button {
                    
                } label: {
                    Text("Создать")
                        .font(.regular(size: 14))
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
    }
}

#Preview {
    RegistrationView()
}
