import Foundation

protocol UserDataServiceProtocol {
    func login(email: String, password: String) async -> Result<UserResponse, RequestError>
    func createUser(email: String, name: String, password: String) async -> Result<User, RequestError>
}

class UserService: UserDataServiceProtocol {
    let userDataService = UserDataService()
    
    func login(email: String, password: String) async -> Result<UserResponse, RequestError> {
        let result = await userDataService.login(email: email, password: password)
        switch result {
        case .success(let success):
            return .success(success)
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
    func createUser(email: String, name: String, password: String) async -> Result<User, RequestError> {
        let result = await userDataService.createUser(email: email, name: name, password: password)
        switch result {
        case .success(let success):
            return .success(success)
        case .failure(let failure):
            return .failure(failure)
        }
    }
}

class UserDataService: Request, UserDataServiceProtocol {
    static let userDataService = UserDataService()
    
    func login(email: String, password: String) async -> Result<UserResponse, RequestError> {
        return await sendRequest(endpoint: UserEndpoint.login(email: email, password: password), responseModel: UserResponse.self)
    }
    
    func createUser(email: String, name: String, password: String) async -> Result<User, RequestError> {
        return await sendRequest(endpoint: UserEndpoint.createUser(email: email, name: name, password: password), responseModel: User.self)
    }
}
