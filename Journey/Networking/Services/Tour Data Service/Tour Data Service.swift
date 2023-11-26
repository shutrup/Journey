import Foundation

protocol TourDataServiceProtocol {
    func fetch() async -> Result<[Tour], RequestError>
    func search(title: String) async -> Result<[Tour], RequestError>
    func fetchCategories() async -> Result<[Category], RequestError>
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
    
    func fetchCategories() async -> Result<[Category], RequestError> {
        let result = await tourDataService.fetchCategories()
        
        switch result {
        case .success(let success):
            return .success(success)
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
    func search(title: String) async -> Result<[Tour], RequestError> {
        let result = await tourDataService.search(title: title)
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
    
    func fetchCategories() async -> Result<[Category], RequestError> {
        return await sendRequest(endpoint: TourEndpoint.fetchCategories, responseModel: [Category].self)
    }
    
    func search(title: String) async -> Result<[Tour], RequestError> {
        return await sendRequest(endpoint: TourEndpoint.search(title: title), responseModel: [Tour].self)
    }
}
