import Foundation

enum TourEndpoint: Endpoint {
    case fetch
    case fetchCategories
    case fetchCategory(id: String)
    
    var path: String {
        switch self {
        case .fetch:
            return API.TourAPI.fetch
        case .fetchCategories:
            return API.CategoryAPI.fetchAllCategories
        case .fetchCategory(let id):
            return API.CategoryAPI.fetchSingleCategory + "/" + id
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .fetch, .fetchCategories, .fetchCategory:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .fetch, .fetchCategories, .fetchCategory:
            return nil
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .fetch, .fetchCategories, .fetchCategory:
            return nil
        }
    }
}
