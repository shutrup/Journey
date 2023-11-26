import SwiftUI

enum AuthStatus {
    case none, loading, loaded, failure
}

@MainActor
final class AuthViewModel: ObservableObject {
    let userDataService: UserDataServiceProtocol
    
    init(userDataService: UserDataServiceProtocol) {
        self.userDataService = userDataService
    }
    // Login View
    @Published var email = String()
    @Published var password = String()
    @Published var name = String()
    @Published var confirmPassword = String()
    @Published var showRegistrView = Bool()
    @Published var authStatus: AuthStatus = .none
    
    @Published var errorMessage: String? {
        didSet {
            if errorMessage != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.errorMessage = nil
                    }
                }
            }
        }
    }
    @Published var showingPopup = false
    @Published var serverErrorMessage: String? {
        didSet {
            if serverErrorMessage != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.serverErrorMessage = nil
                        self.showingPopup = false
                    }
                }
            }
        }
    }
    
    var isEmailValid: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    func login() async {
        authStatus = .loading
        
        let result = await userDataService.login(email: email, password: password)
        switch result {
        case .success(let data):
            authStatus = .loaded
            Constants.userID = data.user._id
        case .failure(let error):
            authStatus = .failure
            switch error {
            case .serverError(let error):
                serverErrorMessage = error
                showingPopup = true
            default:
                print("Ошибка: \(error)")
            }
        }
    }
    
    func registration() async {
        authStatus = .loading
        
        let result = await userDataService.createUser(email: email, name: name, password: password)
        switch result {
        case .success:
            Task {
                await login()
            }
        case .failure(let error):
            authStatus = .failure
            switch error {
            case .serverError(let error):
                serverErrorMessage = error
                showingPopup = true
            default:
                print("Ошибка: \(error)")
            }
        }
    }
    
    func validateLoginFields() -> Bool {
        withAnimation {
            errorMessage = nil
            
            guard !email.isEmpty && !password.isEmpty else {
                errorMessage = "Все поля должны быть заполнены"
                return false
            }
            
            guard isEmailValid else {
                errorMessage = "Некорректный email"
                return false
            }

            guard password.count >= 8 else {
                errorMessage = "Пароль должен быть не менее 8 символов"
                return false
            }

            return true
        }
    }
    
    func validateRegistrationFields() -> Bool {
        withAnimation {
            errorMessage = nil
            
            guard !email.isEmpty && !password.isEmpty && !name.isEmpty && !confirmPassword.isEmpty else {
                errorMessage = "Все поля должны быть заполнены"
                return false
            }
            
            guard isEmailValid else {
                errorMessage = "Некорректный email"
                return false
            }

            guard password.count >= 8 else {
                errorMessage = "Пароль должен быть не менее 8 символов"
                return false
            }

            guard password == confirmPassword else {
                errorMessage = "Пароли не совпадают"
                return false
            }

            return true
        }
    }
}
