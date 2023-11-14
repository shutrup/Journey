import SwiftUI

struct LoginView: View {
    @State private var email = String()
    @State private var password = String()
    @State private var showRegistrView = Bool()
    
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
            
            VStack {
                textFields
                
                buttons
                
                Spacer()
                
                GoogleAndFacebookButtons(googleAction: {}, facebookAction: {})
            }
            .padding(.top, 150)
            .padding(.vertical)
        }
        .navigationDestination(isPresented: $showRegistrView, destination: {
            RegistrationView()
                .navigationBarBackButtonHidden(true)
        })
        .edgesIgnoringSafeArea(.bottom)
        .ignoresSafeArea()
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}

extension LoginView {
    private var textFields: some View {
        VStack {
            JourneyTitleView()
            
            VStack(spacing: 7) {
                RoundedTextField(placeholder: "Почта", text: $email, imageName: isEmailValid ? "checkmark" : "", isSecure: false, imageColor: .green)
                
                RoundedTextField(placeholder: "Пароль", text: $password, isSecure: true, imageColor: .secondary)
            }
            .padding(.top, 110)
        }
    }
    private var buttons: some View {
        HStack {
            Button {
                showRegistrView.toggle()
            } label: {
                Text("Регистрация")
                    .font(.regular(size: 14))
                    .foregroundStyle(.white)
                    .padding(.leading, 31)
                    .padding(.trailing, 32)
                    .padding(.vertical, 17)
                    .frame(height: 51, alignment: .center)
                    .background(.white.opacity(0.2))
                    .cornerRadius(16)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Войти")
                    .font(.regular(size: 14))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 0)
                    .padding(.vertical, 17)
                    .frame(width: 175, height: 51, alignment: .center)
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
        }
        .padding(.top, 20)
        .padding(.horizontal, 16)
    }
}
