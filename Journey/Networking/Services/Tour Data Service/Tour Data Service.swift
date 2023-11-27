import Foundation

protocol TourDataServiceProtocol {
    func fetch() async -> Result<[Tour], RequestError>
    func search(title: String) async -> Result<[Tour], RequestError>
    func fetchByCategory(id: String) async -> Result<[Tour], RequestError>
    func fetchCategories() async -> Result<[Category], RequestError>
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
    
    func fetchByCategory(id: String) async -> Result<[Tour], RequestError> {
        return await sendRequest(endpoint: TourEndpoint.fetchByCategory(id: id), responseModel: [Tour].self)
    }
}
