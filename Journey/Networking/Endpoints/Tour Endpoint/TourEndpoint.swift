import Foundation

enum TourEndpoint: Endpoint {
    case fetch
    
    var path: String {
        switch self {
        case .fetch:
            return API.TourAPI.fetch
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .fetch:
            return .get
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        return nil
    }
}
