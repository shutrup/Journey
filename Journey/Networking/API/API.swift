import Foundation

struct API {
    static var baseURL = "http://localhost:3000"
    
    struct UserAPI {
        static let login = "/user/login"
        static let fetchSingleUser = "/user/"
        static let fetchAllUsers = "/user/fetch"
        static let create = "/user/create"
    }
    
    struct TourAPI {
        static let fetch = "/tour/fetch"
        static let search = "/tours/search/"
        static let fetchByCategory = "/tours/byCategory"
    }
    
    struct CategoryAPI {
        static let fetchAllCategories = "/category/fetch"
        static let fetchSingleCategory = "/category/"
    }
}

