import Foundation

enum TourEndpoint: Endpoint {
    case fetch
    case search(title: String)
    case fetchByCategory(id: String)
    case fetchCategories
    case fetchCategory(id: String)
    
    var path: String {
        switch self {
        case .fetch:
            return API.TourAPI.fetch
        case .search:
            return API.TourAPI.search
        case .fetchCategories:
            return API.CategoryAPI.fetchAllCategories
        case .fetchCategory(let id):
            return API.CategoryAPI.fetchSingleCategory + "/" + id
        case .fetchByCategory:
            return API.TourAPI.fetchByCategory
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .fetch, .fetchCategories, .fetchCategory, .search, .fetchByCategory:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .fetch, .fetchCategories, .fetchCategory, .search, .fetchByCategory:
            return nil
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .search(let title):
            return [
                "title" : title.utf8
            ]
        case .fetchByCategory(let id):
            return [
                "categoryId" : id
            ]
        case .fetch, .fetchCategories, .fetchCategory:
            return nil
        }
    }
}
