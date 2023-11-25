import Foundation

protocol TourDataServiceProtocol {
    func fetch() async -> Result<[Tour], RequestError>
}

class TourService: TourDataServiceProtocol {
    let tourDataService = TourDataService()
    
    func fetch() async -> Result<[Tour], RequestError> {
        let result = await tourDataService.fetch()
        
        switch result {
        case .success(let success):
            return .success(success)
        case .failure(let failure):
            return .failure(failure)
        }
    }
}

class TourDataService: Request, TourDataServiceProtocol {
    static let tourDataService = TourDataService()
    
    func fetch() async -> Result<[Tour], RequestError> {
        return await sendRequest(endpoint: TourEndpoint.fetch, responseModel: [Tour].self)
    }
}
