import SwiftUI
import SDWebImageSwiftUI
import PopupView

struct LoginView: View {
    @EnvironmentObject var store: Store
    @StateObject var viewModel = AuthViewModel(userDataService: UserDataService.userDataService)
    
    var body: some View {
        ZStack {
            Image("previewImage")
                .resizable()
                .padding(-5)
                .blur(radius: 3)
            
            VStack {
                textFields
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.rubikRegular(size: 14))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                }
                
                buttons
                
                Spacer()
                
                GoogleAndFacebookButtons(googleAction: {}, facebookAction: {})
            }
            .padding(.top, 150)
            .padding(.vertical)
        }
        .navigationDestination(isPresented: $viewModel.showRegistrView, destination: {
            RegistrationView()
                .navigationBarBackButtonHidden(true)
                .environmentObject(store)
        })
        .edgesIgnoringSafeArea(.bottom)
        .ignoresSafeArea()
        .onTapGesture {
            UIApplication.shared.endEditing()
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
    NavigationStack {
        LoginView()
            .environmentObject(Store())
    }
}

extension LoginView {
    private var textFields: some View {
        VStack {
            JourneyTitleView()
            
            VStack(spacing: 7) {
                RoundedTextField(placeholder: "Почта", text: $viewModel.email, imageName: viewModel.isEmailValid ? "checkmark" : "", isSecure: false, imageColor: .green)
                
                RoundedTextField(placeholder: "Пароль", text: $viewModel.password, isSecure: true, imageColor: .secondary)
            }
            .padding(.top, 110)
        }
    }
    private var buttons: some View {
        HStack {
            Button {
                viewModel.showRegistrView.toggle()
            } label: {
                Text("Регистрация")
                    .font(.rubikRegular(size: 14))
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
                Task {
                    await viewModel.login()
                    
                    if viewModel.authStatus == .loaded {
                        withAnimation {
                            store.showLogInScreen = false
                        }
                    }
                }
            } label: {
                if viewModel.authStatus == .loading {
                    ActivityIndicator(viewModel.authStatus == .loading ? .constant(true) : .constant(true))
                } else {
                    Text("Войти")
                }
            }
            .font(.rubikRegular(size: 14))
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
        .padding(.top, 20)
        .padding(.horizontal, 16)
    }
}
