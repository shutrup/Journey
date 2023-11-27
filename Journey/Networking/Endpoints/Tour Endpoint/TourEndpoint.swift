import Foundation

enum TourEndpoint: Endpoint {
    case fetch
    case search(title: String)
    case fetchByCategory(id: String)
    case filter(startDate: String?, endDate: String?, minPrice: String?, maxPrice: String?, startCity: String?, groupSize: String?)
    
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
        case .filter:
            return API.TourAPI.filter
        case .fetchCategory(let id):
            return API.CategoryAPI.fetchSingleCategory + "/" + id
        case .fetchByCategory:
            return API.TourAPI.fetchByCategory
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .fetch, .fetchCategories, .fetchCategory, .search, .fetchByCategory, .filter:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .fetch, .fetchCategories, .fetchCategory, .search, .fetchByCategory, .filter:
            return nil
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .search(let title):
            return [
                "title" : title
            ]
        case .fetchByCategory(let id):
            return [
                "categoryId" : id
            ]
        case .filter(let startDate, let endDate, let minPrice, let maxPrice, let startCity, let groupSize):
            return [
                "startDate" : startDate ?? "",
                "endDate" :  endDate ?? "",
                "minPrice" : minPrice ?? "",
                "maxPrice" : maxPrice ?? "",
                "startCity" : startCity ?? "",
                "groupSize" : groupSize ?? ""
            ]
        case .fetch, .fetchCategories, .fetchCategory:
            return nil
        }
    }
}
