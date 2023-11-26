import Foundation

enum TourEndpoint: Endpoint {
    case fetch
    case search(title: String)
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
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .fetch, .fetchCategories, .fetchCategory, .search:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .fetch, .fetchCategories, .fetchCategory, .search:
            return nil
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .search(let title):
            print(title)
            return [
                "title" : title.utf8
            ]
        case .fetch, .fetchCategories, .fetchCategory:
            return nil
        }
    }
}
