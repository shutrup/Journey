
import Foundation

enum UserServiceEndpoint: Endpoint {
    case login(email: String, password: String)
    case createUser(email: String, name:String, password: String)
    
    var path: String {
        switch self {
        case .login:
            return API.UserAPI.login
        case .createUser:
            return API.UserAPI.create
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .login, .createUser:
            return .post
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        switch self {
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
