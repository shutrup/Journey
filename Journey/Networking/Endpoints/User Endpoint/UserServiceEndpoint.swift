
import Foundation

enum UserEndpoint: Endpoint {
    case login(email: String, password: String)
    case createUser(email: String, name:String, password: String)
    case fetchUser(id: String)
    
    var path: String {
        switch self {
        case .login:
            return API.UserAPI.login
        case .createUser:
            return API.UserAPI.create
        case .fetchUser:
            return API.UserAPI.fetchSingleUser
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .fetchUser:
            return .get
        case .login, .createUser:
            return .post
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .fetchUser(let id):
            return [
                "id" : id
            ]
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        case .createUser(let email, let name, let password):
            return [
                "email": email,
                "name": name,
                "password": password
            ]
        }
    }
}
