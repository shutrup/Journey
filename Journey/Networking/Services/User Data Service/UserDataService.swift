import Foundation

protocol UserDataServiceProtocol {
    func login(email: String, password: String) async -> Result<UserResponse, RequestError>
    func createUser(email: String, name: String, password: String) async -> Result<User, RequestError>
    func fetchUser(id: String) async -> Result<User, RequestError>
}


class UserDataService: Request, UserDataServiceProtocol {
    static let userDataService = UserDataService()
    
    func login(email: String, password: String) async -> Result<UserResponse, RequestError> {
        return await sendRequest(endpoint: UserEndpoint.login(email: email, password: password), responseModel: UserResponse.self)
    }
    
    func createUser(email: String, name: String, password: String) async -> Result<User, RequestError> {
        return await sendRequest(endpoint: UserEndpoint.createUser(email: email, name: name, password: password), responseModel: User.self)
    }
    
    func fetchUser(id: String) async -> Result<User, RequestError> {
        return await sendRequest(endpoint: UserEndpoint.fetchUser(id: id), responseModel: User.self)
    }
}
