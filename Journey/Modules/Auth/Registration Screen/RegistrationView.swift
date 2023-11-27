import SwiftUI
import PopupView

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
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.rubikRegular(size: 14))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                }
                
                Button {
                    guard viewModel.validateRegistrationFields() else { return }
                    
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
            .padding(.top, 30)
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
                
                store.userId = viewModel.user?._id ?? ""
                
                withAnimation {
                    store.showLogInScreen = false
                }
            }
        }
        .popup(isPresented: $viewModel.showingPopup) {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.white)
                Text(viewModel.serverErrorMessage ?? "")
                    .font(.rubikRegular(size: 14))
                    .foregroundColor(.white)
            }
            .frame(width: 280, height: 60)
            .background(Color.red)
            .cornerRadius(15.0)
            .shadow(radius: 10)
        } customize: {
            $0.type(.floater())
                .position(.top)
                .animation(.spring())
                .autohideIn(3)
        }
    }
}

#Preview {
    RegistrationView()
        .environmentObject(Store())
}
