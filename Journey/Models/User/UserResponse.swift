import Foundation

struct UserResponse: Codable {
    let user: User
    let token: String
}

struct ErrorResponse: Codable {
    let error: String
}
